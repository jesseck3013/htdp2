;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise97) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define-struct vec [x y])
; A vec is
;   (make-vec PositiveNumber PositiveNumber)
; interpretation represents a velocity vector

; number -> boolean
; return #true when the input is a positive number
(check-expect (positive-number? 1) #true)
(check-expect (positive-number? -1) #false)
(check-expect (positive-number? "xxx") #false)
(check-expect (positive-number? #true) #false)
(define (positive-number? n)
  (and (number? n)
       (> n 0)))

; PositiveNumber PositiveNumber -> vec
(check-expect (checked-make-vec 10 10) (make-vec 10 10))
;; (check-expect (checked-make-vec "x" 10) (error "the inputs should be PositiveNumber"))
(define (checked-make-vec x y)
  (if
   (and (positive-number? x)
        (positive-number? y))
   (make-vec x y)
   (error "the inputs should be PositiveNumber")))
