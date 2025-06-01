;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise41) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define WIDTH-OF-WORLD 200)
(define WHEEL-RADIUS 10)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

; draw the upper part of a car
(define CAR-TOP
  (rectangle
   (* WHEEL-RADIUS 5)
   (* WHEEL-RADIUS 2)
   "solid" "red"))

; draw the bottom part of a car
(define CAR-BOTTOM
  (rectangle
   (* WHEEL-RADIUS 15)
   (* WHEEL-RADIUS 3)
   "solid" "red"))

; draw a wheel
(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))

; draw two wheels horizotally
(define TWO-WHEELS
  (overlay/offset
   WHEEL
   WHEEL-DISTANCE
   0
   WHEEL))

; combine every component to draw a car
(define CAR
  (above
   CAR-TOP
   CAR-BOTTOM
   TWO-WHEELS))

; WorldState -> WorldState 
; moves the car by 3 pixels for every clock tick
; examples: 
;   given: 20, expect 23
;   given: 78, expect 81
(define (tock cw)
  (+ cw 3))

(check-expect (tock 20) 23)
(check-expect (tock 78) 81)

(define tree
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))


(define Y-CAR 165)
(define BACKGROUND (empty-scene 1000 200))
; WorldState -> Image
; places the car into the BACKGROUND scene,
; according to the given world state 
 (define (render cw)
   (place-image tree
                (/ (image-width BACKGROUND) 2)
                (/ (image-height BACKGROUND) 2)
                (place-image CAR cw Y-CAR BACKGROUND)))

; WorldState -> Boolean
; after each event, big-bang evaluates (end? cw) 
(define (end? cw)
  (>= cw (image-width BACKGROUND)))

(define (main cw)
  (big-bang cw
    [to-draw render]
    [on-tick tock]
    [stop-when end?]))
