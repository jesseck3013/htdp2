;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname big-bang) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define (number->square s)
  (square s "solid" "red"))

(number->square 5)
(number->square 10)
(number->square 20)

;(big-bang 100 [to-draw number->square])

;(big-bang 100
;  [to-draw number->square]
;  [on-tick sub1]1
;  [stop-when zero?])

(define (reset s ke)
  100)

;(big-bang 100
;    [to-draw number->square]
;    [on-tick sub1]
;    [stop-when zero?]
;    [on-key reset])

(define BACKGROUND (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))
         
(define (main y)
  (big-bang y
    [on-tick sub1]
    [stop-when zero?]
    [to-draw place-dot-at]
    [on-key stop]))
         
(define (place-dot-at y)
  (place-image DOT 50 y BACKGROUND))
         
(define (stop y ke)
  0)

(main 90)

