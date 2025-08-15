;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise455) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; A UFO is a Posn
; interpretation (make-posn x y) is the UFO's location
; (using the top-down, left-to-right convention)

(define-struct tank [loc vel])
; A Tank is a structure:
; (make-tank Number Number)
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick

(define-struct sigs [ufo tank missile])
; A SIGS.v2 (short for SIGS version 2) is a structure:
;   (make-sigs UFO Tank MissileOrNot)
; interpretation represents the complete state of a
; space invader game
 
; A MissileOrNot is one of: 
; – #false
; – [List-of Posn]
; interpretation#false means the missile is in the tank;
; Posn says the missile is at that location

; SIGS -> Image
; adds TANK, UFO and possibly MISSILE to
; the BACKGROUND scene
(define (si-render s)
  (cond
    [(false? (sigs-missile s))
     (tank-render
      (sigs-tank s)
      (ufo-render (sigs-ufo s) BACKGROUND))]
    [else
     (tank-render
      (sigs-tank s)
      (ufo-render (sigs-ufo s)
                  (missile-render
                   (sigs-missile s) BACKGROUND)))]))

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
  (foldr (lambda (item rst)
           (place-image
            MISSILE
            (posn-x item)
            (posn-y item)
            rst)) im m))

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
                            (list (make-posn 10 50))) #true)
(check-expect (missile-hit? (make-posn 100 50)
                            (list (make-posn 10 50))) #false)
(define (missile-hit? u m)
  (ormap (lambda (item)
           (and 
            (< 
             (abs (- (posn-x u)
                     (posn-x item))) (/ UFO-WIDTH 2))
            (< 
             (abs (- (posn-y u)
                     (posn-y item))) (/ UFO-HEIGHT 2)))) m))
; SIGS -> Bool
; output #true when one of these situation happens:
; - the UFO lands
; - the missile hits the UFO
(define AIM-NOT-OVER (make-sigs (make-posn 50 100)
                                (make-tank 50 3)
                                #false))
(check-expect (si-game-over?
               AIM-NOT-OVER) #false)

(define AIM-OVER (make-sigs (make-posn 50 200)
                            (make-tank 50 3)
                            #false))
(check-expect (si-game-over? AIM-OVER) #true)

(define FIRED-LAND-OVER (make-sigs (make-posn 50 200)
                                   (make-tank 50 3)
                                   (list (make-posn 50 3))))
(check-expect (si-game-over? FIRED-LAND-OVER) #true)

(define FIRED-HIT-OVER (make-sigs (make-posn 50 100)
                                  (make-tank 50 3)
                                  (list (make-posn 50 100))))
(check-expect (si-game-over? FIRED-HIT-OVER) #true)

(define FIRED-NOT-OVER (make-sigs (make-posn 50 100)
                                  (make-tank 50 3)
                                  (list (make-posn 50 50))))
(check-expect (si-game-over? FIRED-NOT-OVER) #false)
(define (si-game-over? s)
  (cond
    [(false? (sigs-missile s))
     (ufo-land? (sigs-ufo s))]
    [else
     (or (ufo-land? (sigs-ufo s))
         (missile-hit? (sigs-ufo s) (sigs-missile s)))]))

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
    [(false? (sigs-missile s)) LOSE]
    [else
     (if (ufo-land? (sigs-ufo s))
         LOSE
         WIN)]))

(define (si-move w)
  (si-move-proper w (random 5)))

(define UFO-VEL 5)
(define TANK-VEL 10)
(define MISSILE-VEL (* UFO-VEL 2))

; Missile -> Missile
(define (move-missile m)
  (map (lambda (item)
         (make-posn
          (posn-x item)
          (- (posn-y item) MISSILE-VEL))) m))

; SIGS Number -> SIGS 
; moves the space-invader objects predictably by delta
(check-expect (si-move-proper AIM-NOT-OVER 10)
              (make-sigs (make-posn 60 105)
                         (make-tank 53 3)
                         #false))

(check-expect (si-move-proper FIRED-NOT-OVER 10)
              (make-sigs (make-posn 60 105)
                         (make-tank 53 3)
                         (list (make-posn 50 40))))
(define (si-move-proper w delta)
  (cond
    [(false? (sigs-missile w))
     (make-sigs
      ; make-ufo
      (make-posn
       (+ (posn-x (sigs-ufo w)) delta)
       (+ (posn-y (sigs-ufo w)) UFO-VEL))
      (make-tank (+
                  (tank-loc (sigs-tank w))
                  (tank-vel (sigs-tank w)))
                 (tank-vel (sigs-tank w)))
      #false)]
    [else
     (make-sigs
      ; make-ufo
      (make-posn
       (+ (posn-x (sigs-ufo w)) delta)
       (+ (posn-y (sigs-ufo w)) UFO-VEL))
      (make-tank (+
                  (tank-loc (sigs-tank w))
                  (tank-vel (sigs-tank w)))
                 (tank-vel (sigs-tank w)))
      (move-missile (sigs-missile w)))]))

; Tank -> Tank
; if tank's direction is right, change it to left
(check-expect (move-left (make-tank 10 -5))
              (make-tank 10 -5))
(check-expect (move-left (make-tank 10 5))
              (make-tank 10 -5))
(define (move-left t)
  (make-tank
   (tank-loc t)
   (if (> (tank-vel t) 0)
       (- (tank-vel t))
       (tank-vel t))))

; Tank -> Tank
; if tank's direction is left, change it to right
(check-expect (move-right (make-tank 10 -5))
              (make-tank 10 5))
(check-expect (move-right (make-tank 10 5))
              (make-tank 10 5))
(define (move-right t)
  (make-tank
   (tank-loc t)
   (if (< (tank-vel t) 0)
       (- (tank-vel t))
       (tank-vel t))))

; SIGS (aim) -> SIGS (fired)
; create the initial state of firing a MISSILE
(check-expect (fire AIM-NOT-OVER)
              (make-sigs (make-posn 50 100)
                          (make-tank 50 3)
                          (list (make-posn 50 (- HEIGHT TANK-HEIGHT)))))
(check-expect (fire (fire AIM-NOT-OVER))
              (make-sigs (make-posn 50 100)
                          (make-tank 50 3)
                          (list (make-posn 50 (- HEIGHT TANK-HEIGHT))
                                (make-posn 50 (- HEIGHT TANK-HEIGHT)))))

(define (fire s)
  (make-sigs (sigs-ufo s)
             (sigs-tank s)
             (cons (make-posn (tank-loc (sigs-tank s))
                              (- HEIGHT TANK-HEIGHT))
                   (cond
                     [(false? (sigs-missile s)) '()]
                     [(empty? (sigs-missile s)) '()]
                     [else (sigs-missile s)]))))

; SIGS String -> SIGS
; key event handler that reacts to these keys:
; - left
; - right
; - space bar
(check-expect (si-control AIM-NOT-OVER "left")
              (make-sigs (make-posn 50 100)
                         (make-tank 50 -3)
                         #false))
(check-expect (si-control AIM-NOT-OVER "right")
              (make-sigs (make-posn 50 100)
                         (make-tank 50 3)
                         #false))
(check-expect (si-control AIM-NOT-OVER " ")
              (make-sigs (make-posn 50 100)
                          (make-tank 50 3)
                          (list (make-posn 50 (- HEIGHT TANK-HEIGHT)))))
(check-expect (si-control FIRED-NOT-OVER "left")
              (make-sigs (make-posn 50 100)
                          (make-tank 50 -3)
                          (list (make-posn 50 50))))
(check-expect (si-control FIRED-NOT-OVER "right")
              (make-sigs (make-posn 50 100)
                         (make-tank 50 3)
                         (list (make-posn 50 50))))
(check-expect (si-control FIRED-NOT-OVER " ") (make-sigs (make-posn 50 100)
                                                         (make-tank 50 3)
                                                         (list
                                                          (make-posn 50 190)
                                                          (make-posn 50 50))))
(define (si-control s ke)
  (cond
    [(false? (sigs-missile s))
     (cond
       [(string=? ke "left")
        (make-sigs (sigs-ufo s)
                   (move-left (sigs-tank s))
                   #false)]
       [(string=? ke "right")
        (make-sigs (sigs-ufo s)
                   (move-right (sigs-tank s))
                   #false)]
       [(string=? ke " ") (fire s)]
       [else s])]
    [else (cond
            [(string=? ke "left")
             (make-sigs
              (sigs-ufo s)
              (move-left (sigs-tank s))
              (sigs-missile s))]
            [(string=? ke "right")
             (make-sigs
              (sigs-ufo s)
              (move-right (sigs-tank s))
              (sigs-missile s))]
            [(string=? ke " ") (fire s)]
            [else s])]))

(define s0 (make-sigs (make-posn 50 10)
                      (make-tank 50 3)
                      #false))

(big-bang s0
          [to-draw si-render]
          [on-tick si-move 0.3]
          [on-key si-control]
          [stop-when si-game-over? si-render-final?])
