;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise246) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; [List-of Number] [Number -> Number] -> Number
(define (fold lon base func)
  (cond
    [(empty? lon) base]
    [else
     (func (first lon)
           (fold (rest lon) base func))]))

; [List-of Number] -> Number
; computes the sum of 
; the numbers on lon
(define (sum lon)
  (fold lon 0 +))

(check-expect (sum (list 1 2 3)) 6)

; [List-of Number] -> Number
; computes the product of 
; the numbers on l
(define (product lon)
  (fold lon 1 *))

(check-expect (product (list 1 2 3)) 6)
