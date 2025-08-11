;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise455) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define ε 0.001)

; [Number -> Number] Number -> Number
(define (slope f r1)
  (local ((define x1 (+ r1 ε))
          (define x2 (- r1 ε))
          (define y1 (f x1))
          (define y2 (f x2)))    
  (/ (- y2 y1)
     (- x2 x1))))

(check-expect (slope (lambda (x) x) 1) 1)
(check-expect (slope (lambda (x) (* 2 x)) 1) 2)
(check-expect (slope (lambda (x) 10) 1) 0)
(check-expect (slope (lambda (x) (sqr x)) 2) 4)
