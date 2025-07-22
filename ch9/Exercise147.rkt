;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise97) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; NEList-of-Booleans is one of:
; - (cons Boolean '())
; - (cons Boolean NEList-of-Booleans)

; NEList-of-Booleans -> Booleans
; Output #true if every element in the list ne-l is true
(check-expect (all-true (cons #true '())) #true)
(check-expect (all-true (cons #true (cons #true '()))) #true)
(check-expect (all-true (cons #false '())) #false)
(check-expect (all-true (cons #true (cons #false '()))) #false)
(define (all-true ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [else
     (and (first ne-l) (all-true (rest ne-l)))]))

; NEList-of-Booleans -> Booleans
; Output true if one of the element in the list ne-l is #true
(check-expect (one-true (cons #true '())) #true)
(check-expect (one-true (cons #false (cons #true '()))) #true)
(check-expect (one-true (cons #false '())) #false)
(check-expect (one-true (cons #false (cons #false '()))) #false)
(define (one-true ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [else
     (or (first ne-l) (one-true (rest ne-l)))]))

