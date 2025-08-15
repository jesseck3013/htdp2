;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise455) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; Direction is one of:
; - up
; - down
; - left
; - right

; segment is a structure:
; (make-segment posn Direction)
; interpretation: (make-segment p d) means
; the segment is at position p and its moving direction is d.
(define-struct segment [pos direction])

; PositiveNumber PositiveNumber Direction -> segment
(check-expect (new-segment 10 10 "down")
              (make-segment (make-posn 10 10) "down"))
(define (new-segment x y direction)
  (make-segment (make-posn x y)
                  direction))

(define segment1 (make-segment (make-posn 10 10) "down"))

(define worm1 (list  segment1))
; worm is one of:
; (cons segment '())
; (cons segment worm)

; Size of the appearances of the game (e.g background, worm, food size)
(define SIZE 3)
(define WIDTH (* 200 SIZE))
(define HEIGHT (* 200 SIZE))
(define SEGMENT-RADIUS (* 5 SIZE))
(define SEGMENT-IMG (circle SEGMENT-RADIUS "solid" "red"))
(define FOOD-IMG (circle SEGMENT-RADIUS "solid" "GREEN"))
(define BG (empty-scene WIDTH HEIGHT))

; segment -> Image
; put a segment on img
(check-expect (render-segment segment1 BG) (place-image SEGMENT-IMG 10 10 BG))
(define (render-segment seg img)
  (place-image SEGMENT-IMG
               (posn-x (segment-pos seg))
               (posn-y (segment-pos seg))
               img))

; worm -> Image
; put a worm on BG
(check-expect (render-worm worm1)
              (place-image SEGMENT-IMG
                           10 10 BG))
(define (render-worm w)
  (foldr (lambda (w rst)
           (render-segment w
                           rst))
         BG w))

; game -> Image
; render food and worm on BG
(check-expect (render (make-game (make-posn 10 10)
                                 worm1))
              (place-image FOOD-IMG 10 10
                           (render-worm worm1)))
(define (render g)
  (place-image
   FOOD-IMG
   (posn-x (game-food g))
   (posn-y (game-food g))
   (render-worm (game-worm g))))

(define SEGMENT-SPEED (* 2 SEGMENT-RADIUS))

; segment -> segment
; compute the next position of the given segment
(check-expect (next-pos
               (new-segment 10 10 "up")
               (new-segment 10 10 "right"))
              (new-segment 10 (- 10 SEGMENT-SPEED) "right"))
(check-expect (next-pos (new-segment 10 10 "down")
                        (new-segment 10 20 "left"))
              (new-segment
               10
               (+ 10 SEGMENT-SPEED) "left"))
(check-expect (next-pos (new-segment 10 10 "left")
                        (new-segment 10 10 "up"))
              (new-segment
               (- 10 SEGMENT-SPEED) 10 "up"))
(check-expect (next-pos (new-segment 10 10 "right")
                        (new-segment 20 10 "down"))
              (new-segment
               (+ 10 SEGMENT-SPEED) 10 "down"))
(define (next-pos seg prev)
  (cond
    [(string=? (segment-direction seg) "up")
     (new-segment
      (posn-x (segment-pos seg))
      (- (posn-y (segment-pos seg)) SEGMENT-SPEED)
      (segment-direction prev))]
    [(string=? (segment-direction seg) "down")
     (new-segment
      (posn-x (segment-pos seg))
      (+ (posn-y (segment-pos seg)) SEGMENT-SPEED)
      (segment-direction prev))]
    [(string=? (segment-direction seg) "left")
     (new-segment
      (- (posn-x (segment-pos seg)) SEGMENT-SPEED)
      (posn-y (segment-pos seg))
      (segment-direction prev))]
    [(string=? (segment-direction seg) "right")
     (new-segment
      (+ (posn-x (segment-pos seg)) SEGMENT-SPEED)
      (posn-y (segment-pos seg))
      (segment-direction prev))]))

; segment -> segment
(check-expect (next-pos-head segment1)
              (new-segment 10 (+ 10 SEGMENT-SPEED) "down"))
(define (next-pos-head pos)
  (next-pos pos pos))

; game -> game
; update the game state by each clock tick
(define (tock g)
  (cond
    [(eat-food? (game-food g)
                (segment-pos (get-head (game-worm g))))
     (grow-worm-new-food g)]
    [else (make-game (game-food g)
                     (worm-move (game-worm g)))]))

; posn posn -> Boolean
(check-expect (eat-food? (make-posn 1 1)
                         (make-posn 1 1)) #true)
(check-expect (eat-food? (make-posn 1 1)
                         (make-posn 100 1)) #false)
(define (eat-food? p1 p2)
  (and
   (<= (abs (- (posn-x p1) (posn-x p2))) SEGMENT-RADIUS)
   (<= (abs (- (posn-y p1) (posn-y p2))) SEGMENT-RADIUS)))

; game -> game
; grow the worm by 1 segment
; generate a new food at a random position
(define (grow-worm-new-food g)
  (make-game (food-create (game-food g))
             (grow-worm (game-worm g))))

; worm -> worm
(check-expect (grow-worm
               (list segment1))
              (list segment1
                    (next-pos-head segment1)))
(define (grow-worm w)
  (cons (first w)
        (worm-move w)))

; worm -> worm
; update worm position by one clock tick
(check-expect (worm-move worm1)
              (list (next-pos segment1 segment1)))
(define (worm-move w)
  (cond 
    [(empty? (rest w))
     (list (next-pos-head (first w)))]
    [else
     (cons (next-pos (first w) (second w))
           (worm-move (rest w)))]))

; Segment -> Segment
(check-expect (update-direction
               (new-segment 10 10 "down") "up")
              (new-segment 10 10 "up"))
(define (update-direction seg direction)
  (new-segment (posn-x (segment-pos seg))
               (posn-y (segment-pos seg))
               direction))

; worm -> worm
(check-expect
 (update-worm-direction 
  (list segment1 segment1) "right")
 (list segment1
       (new-segment 10 10 "right")))
(define (update-worm-direction w direction)
  (cond
    [(empty? (rest w)) (list (update-direction
                              (first w)
                              direction))]
    [else (cons (first w)
                (update-worm-direction (rest w)
                                       direction))]))

; game -> game
(check-expect
 (key-handler (make-game (make-posn 1 1) worm1) "up")
 (make-game (make-posn 1 1) (key-handler-worm worm1 "up")))
(define (key-handler g ke)
  (make-game (game-food g)
             (key-handler-worm (game-worm g) ke)))

; worm String -> worm
(check-expect (key-handler-worm worm1 "right")
              (list (update-direction segment1 "right")))
(define (key-handler-worm w ke)
  (cond
    [(string=? ke "up")
     (update-worm-direction w "up")]
    [(string=? ke "down")
     (update-worm-direction w "down")]
    [(string=? ke "left")
     (update-worm-direction w "left")]
    [(string=? ke "right")
     (update-worm-direction w "right")]
    [else w]))

; worm -> segment
; get the head of the worm
(check-expect (get-head worm1) segment1)
(define (get-head w)
  (cond
    [(empty? (rest w)) (first w)]
    [else (get-head (rest w))]))

; segment segment -> Boolean
(check-expect
 (segment-same-pos (new-segment 10 10 "down")
                   (new-segment 10 10 "up"))
                   #true)
(check-expect
 (segment-same-pos
  (new-segment 10 20 "down")
  (new-segment 10 10 "up")) #false)
(define (segment-same-pos s1 s2)
  (equal? (segment-pos s1)
          (segment-pos s2)))

; Worm -> Boolean
(check-expect (run-into-itself? segment1
                                (list segment1
                                      segment1)) #true)

(define (run-into-itself? head w)
  (cond
    [(empty? (rest w)) #false]
    [(segment-same-pos
      head
      (first w))
     #true]
    [else (run-into-itself? head (rest w))]))

; worm -> Boolean
(check-expect
 (game-over?-worm (list
               (new-segment 0 10 "left"))) #true)
(check-expect
 (game-over?-worm (list
               (new-segment 10 0 "up"))) #true)
(check-expect
 (game-over?-worm (list
              (new-segment 10 HEIGHT "down"))) #true)
(check-expect
 (game-over?-worm (list
               (new-segment 10 WIDTH "right"))) #true)

(define (game-over?-worm w)
  (or
   (run-into-itself? (get-head w) w)
   (<= (posn-x (segment-pos (get-head w))) 0)
   (<= (posn-y (segment-pos (get-head w))) 0)
   (>= (posn-x (segment-pos (get-head w))) WIDTH)
   (>= (posn-y (segment-pos (get-head w))) HEIGHT)))

; game -> Boolean
; check if worm runs into itself or hit the walls
(check-expect (game-over?
               (make-game
                (make-posn 1 1)
                (list
                 (new-segment 10 WIDTH "right")))) #true)
(define (game-over? g)
  (game-over?-worm (game-worm g)))

(define (render-game-over g)
  (render-game-over-worm (game-worm g)))

(define (render-game-over-worm w)
  (place-image
   (text
    (string-append "game over: "
                   (number->string (length w)))
    32
    "black")
   (/ WIDTH 2)
   (/ HEIGHT 2)
   (render-worm w)))

; Posn -> Posn 
; create a food with random position
; that is not the same as p.
(check-satisfied (food-create (make-posn 1 1)) not=-1-1?)
(define (food-create p)
  (food-check-create
   p (make-posn (random (- WIDTH SEGMENT-SPEED))
                (random (- HEIGHT SEGMENT-SPEED)))))
 
; Posn Posn -> Posn 
; generative recursion 
; if p = candidate, call food-create to generate a new posn
(define (food-check-create p candidate)
  (if (equal? p candidate) (food-create p) candidate))
 
; Posn -> Boolean
; use for testing only 
(define (not=-1-1? p)
  (not (and (= (posn-x p) 1) (= (posn-y p) 1))))

; game is a structure:
; (make-game posn worm)
; interpretation: (make-game f w) means
; the food is at f posn and the worm is w.
(define-struct game [food worm])

; game -> Number
; return the length of the worm
(check-expect (final-restult (make-game (make-posn 1 1)
                                        worm1)) 1)
(check-expect (final-restult (make-game (make-posn 1 1)
                                        worm2)) 6)
(define (final-restult g)
  (length (game-worm g)))

(define (worm-main g)
  (final-restult
   (big-bang g
             [to-draw render]
             [on-tick tock (* SIZE 0.1)]
             [on-key key-handler]
             [stop-when game-over? render-game-over]
             )))

(define worm2
  (list
   segment1
  (next-pos-head segment1)
  (next-pos-head (next-pos-head segment1))
  (next-pos-head (next-pos-head (next-pos-head segment1)))
  (next-pos-head (next-pos-head (next-pos-head (next-pos-head segment1))))
  (next-pos-head (next-pos-head (next-pos-head (next-pos-head (next-pos-head segment1)))))))

(worm-main (make-game (food-create (make-posn 0 0))
                      worm1))
