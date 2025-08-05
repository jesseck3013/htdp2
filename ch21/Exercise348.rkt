;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |20.3|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define-struct and-struct [left right])
(define-struct or-struct [left right])
(define-struct not-struct [expr])

; A BSL-Expr (BSL Expression), is one of:
; - Boolean
; - (make-and-struct BSL-Expr BSL-Expr)
; - (make-or-struct BSL-Expr BSL-Expr)
; - (make-not-struct BSL-Expr)

; BSL-Expr -> Boolean
; Evaluate the given BSL-Expr to a number.
(check-expect (eval-bool-expression #false) #false)
(check-expect (eval-bool-expression
               (make-and-struct #false #true)) #false)
(check-expect (eval-bool-expression
               (make-or-struct #true #false)) #true)
(check-expect (eval-bool-expression
               (make-not-struct #true)) #false)

(check-expect (eval-bool-expression
               (make-not-struct
                (make-and-struct #true #false))) #true)

(define (eval-bool-expression expr)
  (cond
    [(boolean? expr) expr]
    [(and-struct? expr)
     (and (eval-bool-expression (and-struct-left expr))
                 (eval-bool-expression (and-struct-right expr)))]
    [(or-struct? expr)
     (or (eval-bool-expression (or-struct-left expr))
                (eval-bool-expression (or-struct-right expr)))]
    [(not-struct? expr)
     (not (eval-bool-expression (not-struct-expr expr)))]))
