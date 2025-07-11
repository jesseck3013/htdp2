;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise97) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; A UFO is a Posn
; interpretation (make-posn x y) is the UFO's location
; (using the top-down, left-to-right convention)

(define-struct tank [loc vel])
; A Tank is a structure:
; (make-tank Number Number)
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick

; A Missile is a Posn
; interpretation (make-posn x y) is the missile's place

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])
; A SIGS is one
; - (make-aim UFO Tank)
; - (make-fired UFO Tank Missile)
; interpretation represents the complete state of a
; space invader game

; SIGS -> Image
; adds TANK, UFO and possibly MISSILE to
; the BACKGROUND scene
(define (si-render s)
  (cond
    [(aim? s) (tank-render
               (aim-tank s)
               (ufo-render (aim-ufo s) BACKGROUND))]
    [(fired? s) 
     (tank-render
      (fired-tank s)
      (ufo-render (fired-ufo s)
                  (missile-render
                   (fired-missile s) BACKGROUND)))]))

(define TANK-WIDTH 30)
(define TANK-HEIGHT 10)
(define TANK (rectangle
              TANK-WIDTH
              TANK-HEIGHT
              "solid"
              "green"))
; TANK Image -> Image
; adds t to the given image im
(define (tank-render t im)
  (place-image
   TANK
   (tank-loc t)
   (- HEIGHT (/ TANK-HEIGHT 2))
   im))

(define UFO (ellipse 30 20 "solid" "purple"))
; UFO Image -> Image
; adds u to the given image im
(define (ufo-render u im)
  (place-image UFO (posn-x u) (posn-y u) im))

(define MISSILE (rectangle 10 10 "solid" "black"))
; Missile Image -> Image
; adds m to the given image im
(define (missile-render m im)
  (place-image
   MISSILE
   (posn-x m)
   (posn-y m)
   im))


(define WIDTH 200)
(define HEIGHT 200)
(define BACKGROUND (empty-scene WIDTH HEIGHT))
;(define s
;  (make-fired (make-posn 20 100)
;              (make-tank 100 3)
;              (make-posn 22 103)))
(define s
  (make-fired (make-posn 20 10)
              (make-tank 28 -3)
              (make-posn 28 (- HEIGHT TANK-HEIGHT))))


(tank-render
  (fired-tank s)
  (ufo-render (fired-ufo s)
              (missile-render (fired-missile s)
                              BACKGROUND)))

(ufo-render
  (fired-ufo s)
  (tank-render (fired-tank s)
               (missile-render (fired-missile s)
                               BACKGROUND)))

;; The first expression puts the tank on top of the ufo
;; The second expression puts the ufo on top of the tank
;; They output the same result when tank and ufo do not overlay




