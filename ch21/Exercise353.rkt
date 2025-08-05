;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise349) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define-struct add [left right])
(define-struct mul [left right])

; A BSL-var-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-var-expr BSL-var-expr)
; – (make-mul BSL-var-expr BSL-var-expr)

; BSL-var-expr -> Boolean
(check-expect (numeric? 10) #true)
(check-expect (numeric? 'x) #false)
(check-expect (numeric? (make-add 'x 10))
              #false)
(check-expect (numeric? (make-mul 'x 10))
              #false)
(define (numeric? s)
  (cond
    [(number? s) #true]
    [(symbol? s) #false]
    [(add? s) (and
               (numeric? (add-left s))
               (numeric? (add-right s)))]
    [(mul? s) (and
               (numeric? (mul-left s))
               (numeric? (mul-right s)))]))
