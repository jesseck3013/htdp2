;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define-struct db [schema content])
; A DB is a structure: (make-db Schema Content)

; A Schema is a [List-of Spec]
; A Spec is a [List Label Predicate]
; A Label is a String
; A Predicate is a [Any -> Boolean]

; A (piece of) Content is a [List-of Row]
; A Row is a [List-of Cell]
; A Cell is Any
; constraint cells do not contain functions 

; integrity constraint In (make-db sch con), 
; for every row in con,
; (I1) its length is the same as sch's, and
; (I2) its ith Cell satisfies the ith Predicate in sch

(define schema1 `(("Name" ,string?)
                  ("Age" ,integer?)
                  ("Present" ,boolean?)))

(define schema2 `(("Present" ,boolean?)
                  ("Description" ,string?)))

(define s1r1 '("Alice" 35 #true))
(define s1r2 '("Bob" 25 #false))
(define s1r3 '("Carol" 30 #true))
(define s1r4 '("Dave" 32 #false))

(define s2r1 '(#true "presence"))
(define s2r2 '(#false "absence"))

(define db1 (make-db schema1 (list s1r1
                                   s1r2
                                   s1r3
                                   s1r4)))

(define db2 (make-db schema2 (list s2r1
                                   s2r2)))

(define (integrity-check db)
  (local (; Row -> Boolean 
          ; does row satisfy (I1) and (I2) 
          (define (row-integrity-check row)
            (and (= (length row)
                    (length (db-schema db)))
                 (andmap (lambda (s c) [(second s) c])
                         (db-schema db)
                         row))))
    (andmap row-integrity-check (db-content db))))

(check-expect
 (integrity-check (make-db (list
                            (list "name" string?))
                           (list (list 1))))
 #false)

(define projected-content
  `(("Alice" #true)
    ("Bob"   #false)
    ("Carol" #true)
    ("Dave"  #false)))

(define projected-schema
  `(("Name" ,string?) ("Present" ,boolean?)))

(define projected-db
  (make-db projected-schema projected-content))

(check-expect
 (db-content (project db1 '("Name" "Present")))
 projected-content)

(define (project db labels)
  (local ((define schema  (db-schema db))
          (define content (db-content db))
 
          ; Spec -> Boolean
          ; does this column belong to the new schema
          (define (keep? c)
            (member? (first c) labels))
 
          ; Row -> Row 
          ; retains those columns whose name is in labels
          (define (row-project row)
            (foldr (lambda (cell m c) (if m (cons cell c) c))
                   '()
                   row
                   mask))
          (define mask (map keep? schema)))
    (make-db (filter keep? schema)
             (map row-project content))))

; DB [List-of labels] [Row -> Boolean] -> [List-of Rows]
(define (select db labels predicate)
  (local (
          (define schema (db-schema db))
          (define content (db-content db))
          (define filtered-content
            (filter predicate content))
          (define filtered-db
            (make-db schema filtered-content))
          (define projected-db (project filtered-db labels))
          )
    (db-content projected-db)))

(check-expect
 (select db1
         (list "Name" "Age")
         (lambda (row)
           (>= (second row) 30)))
 (list
  '("Alice" 35)
  '("Carol" 30)
 '("Dave" 32)))

(define schema1-reordered `(("Present" ,boolean?)
                            ("Name" ,string?)
                            ("Age" ,integer?)))

(define s1r1-reordered '(#true "Alice" 35))
(define s1r2-reordered '(#false "Bob" 25))
(define s1r3-reordered '(#true "Carol" 30))
(define s1r4-reordered '(#false "Dave" 32))
(define db1-reordered (make-db schema1-reordered
                               (list s1r1-reordered
                                     s1r2-reordered
                                     s1r3-reordered
                                     s1r4-reordered)))

; Schema [List-of Label] -> [List-of Number]
; Convert labels into their position in schema
(define (index-list sch lol)
  (local (
          (define sch-length (length sch))
          ; String -> Number
          (define (find-pos s sch)
            (cond
              [(empty? sch) #false]
              [else (if (string=? (first (first sch)) s)
                        (- sch-length (length sch))
                        (find-pos s (rest sch)))]))
          )
  (cond
    [(empty? lol) '()]
    [else (cons (find-pos (first lol) sch)
                (index-list sch (rest lol)))])))

(check-expect (index-list schema1 '("Present" "Name" "Age"))
              '(2 0 1))

; DB [List-of Label] -> DB
(define (reorder db lol)
  (local (
          (define schema  (db-schema db))
          (define content (db-content db))
          (define order (index-list schema lol))
          
          ; [X] [List-of X] [List-of Number] -> [List-of X]
          (define (reorder-ref lox loi)
            (cond
              [(empty? loi) '()]
              [else (cons (list-ref lox (first loi))
                          (reorder-ref lox (rest loi)))]))

          (define schema-reordered (reorder-ref schema order))
          (define content-reordered (map (lambda (row)
                                           (reorder-ref row order)) content))
          
          )
    (make-db schema-reordered content-reordered)))

(check-expect (db-content (reorder db1 '("Present" "Name" "Age")))
              (db-content db1-reordered))

; Q: what has to be changed if lol contains fewer labels than there are
; A: The program still works. However, it does not only perform the reorder task. It also removes the missing column. If this is not the expectation, we can add a check to make sure two lists have the same length, otherwise signal an error.

; Q: The labels input contains strings that are not labels of a column in db.
; A: This input breaks the program. We have to add a check to ensure lol does not contain any label that is not in the corresponding schema.
