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

; Schema Schema -> Schema
(check-expect (map first (join-schema schema1 schema2))
              (list "Name" "Age" "Description"))

(define (join-schema s1 s2)
  (cond
    [(empty? (rest s1)) (rest s2)]
    [else (cons (first s1)
                (join-schema (rest s1) s2))]))

; [X] [List-of Rows] -> [List-of Rows]
(check-expect (find-match #true
                          (list s2r1
                                s2r2)) (list
                                        (list "presence")))
(check-expect (find-match #false
                          (list s2r1
                                s2r2)) (list (list "absence")))

(define (find-match x lor)
  (cond
    [(empty? lor) '()]
    [else
     (local (
             (define key (first (first lor)))
             (define values (rest (first lor)))
             )
       (if (equal? x key)
           (cons values
                 (find-match x (rest lor)))
           (find-match x (rest lor))))]))

; [X] [NEList-of X] -> X
(check-expect (get-last (list 1 2 3)) 3)
(define (get-last nel)
  (cond
    [(empty? (rest nel)) (first nel)]
    [else (get-last (rest nel))]))

; [X] [NEList-of X] -> [NEList-of X]
(check-expect (remove-last (list 1 2 3)) (list 1 2))
(define (remove-last nel)
  (cond
    [(empty? (rest nel)) '()]
    [else (cons (first nel)                
                (remove-last (rest nel)))]))

; Row [List-of Rows] -> [List-of Rows]
(check-expect (translate (list 1 2 #true) (list
                                           (list #true "good")
                                           (list #false "bad")))
              (list (list 1 2 "good")))

(check-expect (translate (list 1 2 #true) (list
                                           (list #true "good")
                                           (list #true "good2")
                                           (list #false "bad")))
              (list (list 1 2 "good")
                    (list 1 2 "good2")))

(check-expect (translate '("Alice" 35 #true) (list 
                                                   (list #true "presence")
                                                   (list #true "here")
                                                   (list #false "absence")
                                                   (list #false "there")))
              (list '("Alice" 35 "presence")
                    '("Alice" 35 "here")))

(define (translate r1 lor)
  (local (
          (define key (get-last r1))
          (define matched (find-match key lor))
          (define r1-no-key (remove-last r1))
          )    
  (map (lambda (item)
         (append r1-no-key item)) matched)))

; [List-of Row] [List-of Row] -> [List-of Row]
(check-expect (join-content (list
                             s1r1
                             s1r2
                             s1r3
                             s1r4)
              (list 
               (list #true "presence")
               (list #true "here")
               (list #false "absence")
               (list #false "there")))
              (list '("Alice" 35 "presence")
                    '("Alice" 35 "here")
                    '("Bob" 25 "absence")
                    '("Bob" 25 "there")
                    '("Carol" 30 "presence")
                    '("Carol" 30 "here")
                    '("Dave" 32 "absence")
                    '("Dave" 32 "there")))
(define (join-content lor1 lor2)
  (cond
    [(empty? lor1) '()]
    [else
     (append (translate (first lor1) lor2)
             (join-content (rest lor1) lor2))]))


; DB DB -> DB
(define (join db1 db2)
  (local (
          (define schema1 (db-schema db1))
          (define schema2 (db-schema db2))
          (define content1 (db-content db1))
          (define content2 (db-content db2))
          )
    (make-db (join-schema schema1 schema2)
             (join-content content1 content2))))

(check-expect (db-content (join db1 db2))
              '(("Alice" 35 "presence")
                ("Bob" 25 "absence")
                ("Carol" 30 "presence")
                ("Dave" 32 "absence")))


