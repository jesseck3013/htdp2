;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise455) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))


; [Number -> Number] Number Number -> Number
(define (integrate-rectangle f a b R)
  (local (
          (define W (/ (- b a) R))
          (define S (/ W 2))
          (define (sum-rectangle i)
            (cond
              [(= i R) 0]
              [else
               (+
                (* W (f (+ a (* i W) S)))
                (sum-rectangle (add1 i)))]))
          )
    (sum-rectangle 0)))

(define (integrate R)
  (lambda (f a b)
    (integrate-rectangle f a b R)))

(define ε 0.1)
 
; [Number -> Number] Number Number -> Number
; computes the area under the graph of f between a and b
; assume (< a b) holds 
 
(check-within ((integrate 10) (lambda (x) 20) 12 22) 200 ε)
(check-within ((integrate 10) (lambda (x) (* 2 x)) 0 10) 100 ε)

;; (check-within ((integrate 10) (lambda (x) (* 3 (sqr x))) 0 10)
;;               1000
;;               ε)

;; (check-within ((integrate 20) (lambda (x) (* 3 (sqr x))) 0 10)
;;               1000
;;               ε)

;; (check-within ((integrate 30) (lambda (x) (* 3 (sqr x))) 0 10)
;;               1000
;;               ε)

;; (check-within ((integrate 40) (lambda (x) (* 3 (sqr x))) 0 10)
;;               1000
;;               ε)

(check-within ((integrate 50) (lambda (x) (* 3 (sqr x))) 0 10)
              1000
              ε)

; When R is 50, the 3rd test passed. It failed to pass when R is 10, 20, 30, 40.

; When ε is 0.01, increasing R to 160 can pass the test.
(check-within ((integrate 160) (lambda (x) (* 3 (sqr x))) 0 10)
              1000
              0.01)
