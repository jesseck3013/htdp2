;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise455) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define QUEENS 8)
; A QP is a structure:
;   (make-posn CI CI)
; A CI is an N in [0,QUEENS).
; interpretation (make-posn r c) denotes the square at 
; the r-th row and c-th column

; QP QP -> Boolean
(define (threatening? qp1 qp2)
  (local (
          (define x1 (posn-x qp1))
          (define y1 (posn-y qp1))
          (define x2 (posn-x qp2))
          (define y2 (posn-y qp2))
          )
    (or (= x1 x2)
        (= y1 y2)
        (= (- x2 x1)
           (- y2 y1)))))

(check-expect (threatening? (make-posn 0 0)
                            (make-posn 1 1))
              #true)

(check-expect (threatening? (make-posn 0 0)
                            (make-posn 0 1))
              #true)

(check-expect (threatening? (make-posn 0 0)
                            (make-posn 1 0))
              #true)

(check-expect (threatening? (make-posn 0 0)
                            (make-posn 2 1))
              #false)
