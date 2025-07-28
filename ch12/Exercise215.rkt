;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise215) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))

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
(check-expect (render worm1)
              (place-image SEGMENT-IMG
                           10 10 BG))
(define (render w)
  (cond
    [(empty? (rest w)) (render-segment (first w) BG)]
    [else
     (render-segment (first w) (render (rest w)))]))

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

; worm -> worm
(check-expect (tock worm1)
              (list (next-pos segment1 segment1)))
(define (tock w)
  (cond
    [(empty? (rest w))
     (list (next-pos-head (first w)))]
    [else
     (cons (next-pos (first w) (second w))
           (tock (rest w)))]))

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

; worm String -> worm
(check-expect (key-handler worm1 "right")
              (list (update-direction segment1 "right")))
(define (key-handler w ke)
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

(define (worm-main w)
  (big-bang w
            [to-draw render]
            [on-tick tock (* SIZE 0.1)]
            [on-key key-handler]))

(worm-main (list
            segment1
            (next-pos-head segment1)))
