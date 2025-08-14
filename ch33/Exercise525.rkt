;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise525) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define threshold 0.01)

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

(define A (make-posn 0 0))
(define B (make-posn 0 10))
(define C (make-posn 5 (* 5 (sqrt 3))))
(check-expect (add-triangle (empty-scene 100 100) A B C)
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
