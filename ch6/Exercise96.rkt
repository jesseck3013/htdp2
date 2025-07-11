;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise96) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define WIDTH 200)
(define HEIGHT 200)
(define BG (empty-scene WIDTH HEIGHT))
(define UFO (ellipse 30 20 "solid" "purple"))

(define TANK-WIDTH 30)
(define TANK-HEIGHT 10)
(define TANK (rectangle 30 10 "solid" "green"))
(define MISSILE (rectangle 10 10 "solid" "black"))

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])

; A UFO is a Posn. 
; interpretation (make-posn x y) is the UFO's location 
; (using the top-down, left-to-right convention)
 
(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number). 
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick 
 
; A Missile is a Posn. 
; interpretation (make-posn x y) is the missile's place


(place-image 
 MISSILE
 30 200
 (place-image TANK 50 (- 300 (/ (image-height TANK) 2)) (overlay UFO BG)))


; state 1
(define state1 (make-aim (make-posn 20 10) (make-tank 28 -3)))
(place-image
 TANK (tank-loc (aim-tank state1)) (- HEIGHT (/ TANK-HEIGHT 2))
 (place-image UFO (posn-x (aim-ufo state1)) (posn-y (aim-ufo state1))
              BG))

; state 2
(define state2
  (make-fired (make-posn 20 10)
              (make-tank 28 -3)
              (make-posn 28 (- HEIGHT TANK-HEIGHT))))

(place-image
 MISSILE
 (posn-x (fired-missile state2))
 (posn-y (fired-missile state2))
 (place-image
  TANK (tank-loc (fired-tank state2)) (- HEIGHT (/ TANK-HEIGHT 2))
  (place-image UFO (posn-x (fired-ufo state2)) (posn-y (fired-ufo state2))
               BG)))

; state 3
(define state3
  (make-fired (make-posn 20 100)
              (make-tank 100 3)
              (make-posn 22 103)))

(place-image
 MISSILE
 (posn-x (fired-missile state3))
 (posn-y (fired-missile state3))
 (place-image
  TANK (tank-loc (fired-tank state3)) (- HEIGHT (/ TANK-HEIGHT 2))
  (place-image UFO (posn-x (fired-ufo state3)) (posn-y (fired-ufo state3))
               BG)))
