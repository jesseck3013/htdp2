;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise455) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define ε 0.1)

; [Number -> Number] Number Number -> Number
; Use the Kepler's rule to approxiate the integration of a given function f between [a, b].
(define (integrate-dc f a b)
  (local (
          (define fa (f a))
          (define fb (f b))
          (define mid (/ (+ a b) 2))
          (define (area-of-trapezoid l r fl fr)
            (* 1/2 (- r l) (+ fl fr)))
          )
    (cond
      [(<= (- b a) ε) (area-of-trapezoid a b fa fb)]
      [else (+ (integrate-dc f a mid)
               (integrate-dc f mid b))])))

(define integrate integrate-dc)

 
; [Number -> Number] Number Number -> Number
; computes the area under the graph of f between a and b
; assume (< a b) holds 
 
(check-within (integrate (lambda (x) 20) 12 22) 200 ε)
(check-within (integrate (lambda (x) (* 2 x)) 0 10) 100 ε)
(check-within (integrate (lambda (x) (* 3 (sqr x))) 0 10)
              1000
              ε)
