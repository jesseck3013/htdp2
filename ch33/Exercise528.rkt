;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise528) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define MIN-AREA 1)

(define DOT (circle 5 "solid" "red"))
(define B-DOT (circle 5 "solid" "blue"))

(define MT (empty-scene 400 400))

(define init-img (place-image
                  B-DOT
                  100 380
                  (place-image DOT
                               50 50
                               (place-image DOT 300 200 MT))))

; Posn Posn -> Posn
(define (mid-point p1 p2)
  (local (
          (define x1 (posn-x p1))
          (define y1 (posn-y p1))
          (define x2 (posn-x p2))
          (define y2 (posn-y p2))
          )
  (make-posn (/ (+ x1 x2) 2)
             (/ (+ y1 y2) 2))))

(check-expect (mid-point (make-posn 0 0)
                         (make-posn 2 2))
              (make-posn 1 1))

; Posn Posn Posn -> Number
(define (triangle-area p1 p2 p3)
  (local (
          (define x1 (posn-x p1))
          (define y1 (posn-y p1))
          (define x2 (posn-x p2))
          (define y2 (posn-y p2))
          (define x3 (posn-x p3))
          (define y3 (posn-y p3))
          )
    (abs
     (* 1/2 (+ (* x1 (- y2 y3))
              (* x2 (- y3 y1))
              (* x3 (- y1 y2))
    )
  ))))
(check-expect (triangle-area (make-posn 1 1)
                             (make-posn 4 5)
                             (make-posn 7 1))
              12)

; Posn Posn Posn -> Image
(define (smooth-curve img p1 p2 observer)
  (local (
          (define mid-p1-o (mid-point p1 observer))
          (define mid-p2-o (mid-point p2 observer))
          (define p3 (mid-point mid-p1-o mid-p2-o))
          
          (define left-area (triangle-area p1 mid-p1-o p3))
          (define right-area (triangle-area p1 mid-p1-o p3))
          )
  (cond
    [(and (<= left-area MIN-AREA) (<= right-area MIN-AREA))
     (scene+line
      (scene+line
       img
       (posn-x p3) (posn-y p3)
       (posn-x p2) (posn-y p2)
       "red")
      (posn-x p1) (posn-y p1)
      (posn-x p3) (posn-y p3)
      "red")]
    [(and (> left-area MIN-AREA) (> right-area MIN-AREA))
     (smooth-curve (smooth-curve img p2 p3 mid-p2-o) p1 p3 mid-p1-o)]
    [(> left-area MIN-AREA)
     (scene+line
      (smooth-curve img p1 p3 mid-p1-o)
      (posn-x p3) (posn-y p3)
      (posn-x p2) (posn-y p2)
      "red")]
    [(> right-area MIN-AREA)
     (scene+line
      (smooth-curve img p2 p3 mid-p2-o)
      (posn-x p3) (posn-y p3)
      (posn-x p1) (posn-y p1)
      "red")]
  )))




(define A (make-posn 50 50))
(define B (make-posn 100 380))
(define C (make-posn 300 200))

(smooth-curve init-img A C B)