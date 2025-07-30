;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise246) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; [List-of Item1] Item2 [Item1 -> Item2]-> Item2
(define (fold2 l base func)
  (cond
    [(empty? l) base]
    [else
     (func (first l)
           (fold2 (rest l) base func))]))

; [List-of Number] -> Number
; computes the product of 
; the numbers on l
(define (product lon)
  (fold2 lon 1 *))

(check-expect (product (list 1 2 3)) 6)

; Posn Image -> Image 
(define (place-dot p img)
  (place-image
     dot
     (posn-x p) (posn-y p)
     img))
 
; graphical constants:    
(define emt
  (empty-scene 100 100))
(define dot
  (circle 3 "solid" "red"))

(define (image* l)
  (fold2 l emt place-dot))

(check-expect (image* (list (make-posn 1 1)))
              (place-dot (make-posn 1 1) emt))
