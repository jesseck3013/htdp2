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

(define UFO-WIDTH 30)
(define UFO-HEIGHT 20)
(define UFO (ellipse UFO-WIDTH UFO-HEIGHT "solid" "purple"))
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

; UFO -> Bool
; output #true when UFO lands
(check-expect (ufo-land? (make-posn 10 199)) #true)
(check-expect (ufo-land? (make-posn 10 50)) #false)
(define (ufo-land? u)
  (<= (- HEIGHT (posn-y u)) 3))

; UFO MISSILE -> Bool
; output #true when the missile hits the ufo
(check-expect (missile-hit? (make-posn 10 50)
                            (make-posn 10 50)) #true)
(check-expect (missile-hit? (make-posn 100 50)
                            (make-posn 10 50)) #false)
(define (missile-hit? u m)
  (and 
   (< 
    (abs (- (posn-x u)
            (posn-x m))) (/ UFO-WIDTH 2))
   (< 
    (abs (- (posn-y u)
            (posn-y m))) (/ UFO-HEIGHT 2))))

; SIGS -> Bool
; output #true when one of these situation happens:
; - the UFO lands
; - the missile hits the UFO
(define AIM-NOT-OVER (make-aim (make-posn 50 100)
                               (make-tank 50 3)))
(check-expect (si-game-over?
               AIM-NOT-OVER) #false)

(define AIM-OVER (make-aim (make-posn 50 200)
                           (make-tank 50 3)))
(check-expect (si-game-over? AIM-OVER) #true)

(define FIRED-LAND-OVER (make-fired (make-posn 50 200)
                           (make-tank 50 3)
                           (make-posn 50 3)))
(check-expect (si-game-over? FIRED-LAND-OVER) #true)

(define FIRED-HIT-OVER (make-fired (make-posn 50 100)
                                   (make-tank 50 3)
                                   (make-posn 50 100)))
(check-expect (si-game-over? FIRED-HIT-OVER) #true)

(define FIRED-NOT-OVER (make-fired (make-posn 50 100)
                           (make-tank 50 3)
                           (make-posn 50 50)))
(check-expect (si-game-over? FIRED-NOT-OVER) #false)
(define (si-game-over? s)
  (cond
    [(aim? s)
     (ufo-land? (aim-ufo s))]
    [(fired? s)
     (or (ufo-land? (fired-ufo s))
         (missile-hit? (fired-ufo s) (fired-missile s)))]))

(define WIN (text "WIN" 16 "black"))
(define LOSE (text "LOSE" 16 "black"))
; SIGS -> Image
; render the game over image 
; based on the final state of SIGS.
; the final state could either be win or lose,
; so there are two final scenes.
(check-expect (si-render-final? AIM-OVER) LOSE)
(check-expect (si-render-final? FIRED-LAND-OVER) LOSE)
(check-expect (si-render-final? FIRED-HIT-OVER) WIN)
(define (si-render-final? s)
  (cond
    [(aim? s) LOSE]
    [(fired? s)
     (if (ufo-land? (fired-ufo s))
         LOSE
         WIN)]))
