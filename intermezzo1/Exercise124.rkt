;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise97) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

;; (define PRICE 5)
;; (define SALES-TAX (* 0.08 PRICE))
;; (define TOTAL (+ PRICE SALES-TAX))

(define PRICE 5)
;(define SALES-TAX (* 0.08 5))
(define SALES-TAX 0.4)
;(define TOTAL (+ PRICE SALES-TAX))
;(define TOTAL (+ 5 0.4))
(define TOTAL 5.4)


;; (define COLD-F 32)
;; (define COLD-C (fahrenheit->celsius COLD-F))
;; (define (fahrenheit->celsius f)
;;  (* 5/9 (- f 32)))

; the evaluation signal an error because fahrenheit->celsius is not defined when being called by the definition of COLD-C def

(define LEFT -100)
(define RIGHT 100)
(define (f x) (+ (* 5 (expt x 2)) 10))
(define f@LEFT (f LEFT))
(define f@RIGHT (f RIGHT))
; no error
