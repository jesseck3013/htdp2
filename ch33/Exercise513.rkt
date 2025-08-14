;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |33.1|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; A Lam is one of:
; Symbol
; λ-def
; app

; Lam -> Boolean
(check-expect (is-var? 'x) #true)
(define (is-var? x)
  (symbol? x))

; Lam -> Boolean
(check-expect (is-var? 'x) #true)
(define (is-λ? x)
  (λ-def? x))

; Lam -> Boolean
(check-expect (is-app? 'x) #false)
(check-expect (is-app? ex1) #false)
(check-expect (is-app? ex2) #false)
(check-expect (is-app? ex3) #false)
(check-expect (is-app? ex4) #true)
(define (is-app? l)
  (and
   (not (is-var? l))
   (not (is-λ? l))))

; λ-def is a structure:
; (make-struct Symbol Lam)
(define-struct λ-def [para body])

; app is a structure:
; (make-struct Lam Lam)
(define-struct app [fun arg])

(define ex1 (make-λ-def 'x 'x))
(define ex2 (make-λ-def 'x 'y))
(define ex3 (make-λ-def 'y (make-λ-def (list 'x) 'y)))
(define ex4 (make-app
             (make-λ-def 'x (make-app 'x 'x))
             (make-λ-def 'x (make-app 'x 'x))))
