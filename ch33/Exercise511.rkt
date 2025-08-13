;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |33.1|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; (λ (x) x)
; scope of x: inside the function

; (λ (x) y)
; scope of x: inside the function

; (λ (y) (λ (x) y))
; scope of y: two functions
; scope of x: the inner function

; ((λ (x) x) (λ (x) x))
; scope of x in the left side function: the left function
; scope of x in the right right function: function on the right

; ((λ (x) (x x)) (λ (x) (x x)))
; scope of the x in the left side function:
; function on the left

; scope of the in the right side function:
; function on the right 

; (((λ (y) (λ (x) y)) (λ (z) z)) (λ (w) w)) 
;       1      2  1       3  3       4  4

; (λ (y) (λ (x) y))
; the scope of y: two functions
; the scope of x: the inner function

; (λ (z) z)
; the scope of z is the function

; (λ (w) w)
; the scope of w is the function

; Here (λ (z) z) is the value of z in (λ (y) (λ (x) y))
; that means
; ((λ (y) (λ (x) y)) (λ (z) z))
; ==
; (λ (x) (λ (z) z))

; (λ (w) w) is the value of x in (λ (x) (λ (z) z))
; ((λ (x) (λ (z) z)) (λ (w) w))
; ==
; (λ (z) z)
