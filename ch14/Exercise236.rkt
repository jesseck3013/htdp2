;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |14.1|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; Lon -> Lon
; adds 1 to each item on l
(check-expect (add1* '()) '())
(check-expect (add1* '(1 2 3 4 5))
              '(2 3 4 5 6))
(define (add1* l)
  (cond
    [(empty? l) '()]
    [else
     (cons
       (add1 (first l))
       (add1* (rest l)))]))

; Lon -> Lon
; adds 5 to each item on l
(check-expect (plus5 '()) '())
(check-expect (plus5 '(1 2 3 4 5))
              '(6 7 8 9 10))
(define (plus5 l)
  (cond
    [(empty? l) '()]
    [else
     (cons
       (+ (first l) 5)
       (plus5 (rest l)))]))

; Operation l
(check-expect (my-apply add1 '()) '())
(check-expect (my-apply add1 '(1 2 3)) '(2 3 4))
(define (my-apply op l)
  (cond
    [(empty? l) '()]
    [else
     (cons (op (first l))
           (my-apply op (rest l)))]))


; Lon -> Lon
; adds 1 to each item on l
(check-expect (my-add1* '()) '())
(check-expect (my-add1* '(1 2 3 4 5))
              '(2 3 4 5 6))
(define (my-add1* l)
  (my-apply add1 l))


; Number -> Number
; add 5 to a number
(check-expect (plus-5 0) 5)
(check-expect (plus-5 5) 10)
(define (plus-5 n)
  (+ n 5))

; Lon -> Lon
; adds 5 to each item on l
(check-expect (my-plus5 '()) '())
(check-expect (my-plus5 '(1 2 3 4 5))
              '(6 7 8 9 10))
(define (my-plus5 l)
  (my-apply plus-5 l))

; Number -> Number
(check-expect (sub2 2) 0)
(define (sub2 n)
  (- n 2))

; List-of-number -> List-of-number
(check-expect (sub2* '()) '())
(check-expect (sub2* '(2 3 4 5)) '(0 1 2 3))
(define (sub2* l)
  (my-apply sub2 l))
