;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define-struct db [schema content])
; A DB is a structure: (make-db Schema Content)

; A Schema is a [List-of Spec]

(define-struct spec [label predicate])
; Spec is a structure: (make-spec Label Predicate)

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

(define schema1 `(,(make-spec "Name" string?)
                  ,(make-spec "Age" integer?)
                  ,(make-spec "Present" boolean?)))

(define schema2 `((,make-spec "Present" boolean?)
                  (,make-spec "Description" string?)))

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
