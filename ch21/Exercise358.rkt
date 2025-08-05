;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise349) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define-struct add [left right])
(define-struct mul [left right])
(define-struct fun [name argument])

; fun-def is a structure:
; (make-fun-def Symbol Symbol BSL-fun-expr)
(define-struct fun-def [name argument body])

; A BSL-fun-expr is one of: 
; – Number
; – Symbol
; – (make-add BSL-fun-expr BSL-fun-expr)
; – (make-mul BSL-fun-expr BSL-fun-expr)
; - (make-fun Symbol BSL-fun-expr)

;(define (f x) (+ 3 x))
(define f
  (make-fun-def 'f 'x (make-add 3 'x)))

;(define (g y) (f (* 2 y)))
(define g
  (make-fun-def 'g 'y (make-fun 'f (make-mul 2 'y))))

;(define (h v) (+ (f v) (g v)))
(define h
  (make-fun-def 'h 'v (make-add
                       (make-fun 'f 'v)
                       (make-fun 'g 'v))))

; BSL-fun-def* is one of:
; - '()
; - (cons BSL-fun-def BSL-fun-def*)

(define da-fgh
  (list f g h))

; BSL-fun-def* Symbol -> BSL-fun-def
; retrieves the definition of f in da
; signals an error if there is none
(check-expect (lookup-def da-fgh 'g) g)
(check-error (lookup-def da-fgh 'z))

(define (lookup-def da f)
  (cond
    [(empty? da) (error "function undefined")]
    [(equal?
      (fun-def-name (first da)) f) (first da)]
    [else (lookup-def (rest da) f)]))
