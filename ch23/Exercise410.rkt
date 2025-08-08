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
                                   s1r3)))

(define db2 (make-db schema1 (list s1r2
                                   s1r3
                                   s1r4)))
; DB DB -> DB
(define (db-union db1 db2)
  (local (
          (define schema (db-schema db1))
          (define content1 (db-content db1))
          (define content2 (db-content db2))
          
          ; [List-of Row] [List-of Row] -> [List-of Row]
          (define (union c1 c2)
            (cond
              [(empty? c1) c2]
              [else (if (member? (first c1) c2)
                        (union (rest c1) c2)
                        (cons (first c1)
                              (union (rest c1) c2))
                        )])
            )
          )
    (make-db schema (union content1 content2))))

(check-expect (db-union db1 db2) (make-db
                                  schema1 (list
                                           s1r1
                                           s1r2
                                           s1r3
                                           s1r4)))
