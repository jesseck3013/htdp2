;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define (add n)
  (cond
    [(= n 0) 0]
    [else (+ #i1/185
             (add (sub1 n)))]))
(add 0)
(add 1)
(add 185)
;; Output: 
;; 0
;; #i0.005405405405405406
;; #i0.9999999999999949


(define (sub n)
  (cond
    [(<= n 0) 0]
    [else (add1
             (sub (- n 1/185)))]))

(sub 0)
(sub 1/185)
(sub 1)
(sub #i1.0)
;; Output:
;; 0
;; 1
;; 185
;; 186

;; (- #i1.0 1/185)
;; #i0.9945945945945946

;; (- 1 1/185)
;; 184/185

; (sub 1) is different from (sub #i1.0). Because inexact number uses approximation for a infinite decimal number, every iteration of (sub #i1.0) accumulate errors.
