;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise97) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; N -> Number
; computes (+ n pi) without using +
 
(check-within (add-to-pi 3) (+ 3 pi) 0.001)
 
(define (add-to-pi n)
  (cond
    [(zero? n) pi]
    [(positive? n) (add1 (add-to-pi (sub1 n)))]))

(check-expect (add 1 3) 4)
(define (add x y)
  (cond
    [(zero? x) y]
    [(positive? x) (add1 (add (sub1 x) y))]))

; because pi is an inexact number, BSL does not allow comparison between an exact number and an inexact number.
