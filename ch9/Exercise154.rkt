;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise153) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define-struct layer [color doll])

; An RD (short for Russian doll) is one of: 
; – String 
; – (make-layer String RD)

; RD -> String
; put all colors into a string, and seperate them with commas
(check-expect (colors (make-layer "red" "yellow")) "red, yellow")
(check-expect (colors (make-layer "yellow" (make-layer "green" "red"))) "yellow, green, red")

(define (colors an-rd)
  (cond
    [(string? an-rd) an-rd]
    [(layer? an-rd)
     (string-append (layer-color an-rd)
                    ", "
                    (colors (layer-doll an-rd)))]))
