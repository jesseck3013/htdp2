;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise45) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define cat1 (bitmap "../resources/cat1.png"))

; WorldState: cw is the x-axis of the cat1

; WorldState -> WorldState
; for each tick of the clock, big-bang obtains the next 
; state of the world from (clock-tick-handler cw) 
(define (clock-tick-handler cw)
  (modulo (+ cw 3) (image-width BACKGROUND)))
(check-expect (clock-tick-handler 1) 4)
(check-expect (clock-tick-handler 10) 13)

(define BACKGROUND (empty-scene (* (image-width cat1) 10)
                                (* (image-height cat1) 1.5)))

(define Y-AXIS (/ (image-height BACKGROUND) 2))
; WorldState -> Image
; when needed, big-bang obtains the image of the current 
; state of the world by evaluating (render cw) 
(define (render cw)
  (place-image cat1 cw Y-AXIS BACKGROUND))

(define (cat-prog cw)
  (big-bang cw
   [to-draw render]
   [on-tick clock-tick-handler]))

(cat-prog 0)
