;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise526) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define threshold 5)

; Image Posn Posn Posn -> Image 
; adds the black triangle a, b, c to scene
(define (add-triangle scene a b c)
  (local (
          (define X-a (posn-x a))
          (define Y-a (posn-y a))
          (define X-b (posn-x b))
          (define Y-b (posn-y b))
          (define X-c (posn-x c))
          (define Y-c (posn-y c))
          )
    (scene+line
     (scene+line
      (scene+line
       scene
       X-c Y-c
       X-a Y-a
       "blue")
      X-b Y-b
      X-c Y-c
      "blue")
     X-a Y-a
     X-b Y-b
     "blue")))

(define X (make-posn 0 0))
(define Y (make-posn 0 10))
(define Z (make-posn 5 (* 5 (sqrt 3))))
(check-expect (add-triangle (empty-scene 100 100) X Y Z)
              (scene+line
               (scene+line
                (scene+line
                 (empty-scene 100 100)
                 5 (* 5 (sqrt 3))
                 0 0
                 "blue")
                0 10
                5 (* 5 (sqrt 3))
                "blue")
               0 0
               0 10
               "blue"))
 
; Posn Posn Posn -> Boolean 
; is the triangle a, b, c too small to be divided
(define (too-small? a b c)
  (local (
          (define (distance a b)
            (local (
                    (define X-a (posn-x a))
                    (define Y-a (posn-y a))
                    (define X-b (posn-x b))
                    (define Y-b (posn-y b))
                    )
            (sqrt (+ (sqr (- X-a X-b))
                     (sqr (- Y-a Y-b))))))
          )
    (or (<= (distance a b) threshold)
        (<= (distance b c) threshold)
        (<= (distance c a) threshold))))

(check-expect (too-small? (make-posn 0 0.01)
                          (make-posn 0 0.02)
                          (make-posn 0 0.03))
              #true)

; Posn Posn -> Posn 
; determines the midpoint between a and b
(define (mid-point a b)
  (local (
          (define X-a (posn-x a))
          (define Y-a (posn-y a))
          (define X-b (posn-x b))
          (define Y-b (posn-y b))
          )
    (make-posn (/ (+ X-a X-b) 2)
               (/ (+ Y-a Y-b) 2))))

(check-expect (mid-point (make-posn 2 2)
                         (make-posn 0 0))
              (make-posn 1 1))

; Image Posn Posn Posn -> Image 
; generative adds the triangle (a, b, c) to scene0, 
; subdivides it into three triangles by taking the 
; midpoints of its sides; stop if (a, b, c) is too small
; accumulator the function accumulates the triangles of scene0
(define (add-sierpinski scene0 a b c)
  (cond
    [(too-small? a b c) scene0]
    [else
     (local
       ((define scene1 (add-triangle scene0 a b c))
        (define mid-a-b (mid-point a b))
        (define mid-b-c (mid-point b c))
        (define mid-c-a (mid-point c a))
        (define scene2
          (add-sierpinski scene1 a mid-a-b mid-c-a))
        (define scene3
          (add-sierpinski scene2 b mid-b-c mid-a-b)))
       ; —IN—
       (add-sierpinski scene3 c mid-c-a mid-b-c))]))


(define CENTER (make-posn 200 200))
(define RADIUS 200) ; the radius in pixels 
 
; Number -> Posn
; determines the point on the circle with CENTER 
; and RADIUS whose angle is 
 
; examples
; what are the x and y coordinates of the desired 
; point, when given: 120/360, 240/360, 360/360
 
(define (circle-pt factor)
  (local (
          (define angle (* 2 pi factor))
          (define z (make-polar RADIUS angle))
          )
    (make-posn (+ (posn-x CENTER) (real-part z))
               (- (posn-y CENTER) (imag-part z)))))


(define MT (empty-scene 400 400))
(define A (circle-pt (/ 120 360)))
(define B (circle-pt (/ 240 360)))
(define C (circle-pt (/ 360 360)))
 
(add-sierpinski MT A B C)
