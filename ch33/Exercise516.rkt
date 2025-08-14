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

(define (λ-para l) (λ-def-para l))
(define (λ-body l) (λ-def-body l))

; app is a structure:
; (make-struct Lam Lam)
(define-struct app [fun arg])

(define ex1 (make-λ-def 'x 'x))
(define ex2 (make-λ-def 'x 'y))
(define ex3 (make-λ-def 'y (make-λ-def 'x 'y)))
(define ex4 (make-app
             (make-λ-def 'x (make-app 'x 'x))
             (make-λ-def 'x (make-app 'x 'x))))

; Lam -> Lam 
; replaces all symbols s in le with '*undeclared
; if they do not occur within the body of a λ 
; expression whose parameter is s
 
(check-expect (undeclareds ex1) ex1)
(check-expect (undeclareds ex2) (make-λ-def 'x '*undeclared))
(check-expect (undeclareds ex3) ex3)
(check-expect (undeclareds ex4) ex4)
 
; Lam -> Lam 
(define (undeclareds le0)
  (local (; Lam [List-of Symbol] -> Lam
          ; accumulator declareds is a list of all λ 
          ; parameters on the path from le0 to le
          (define (undeclareds/a le declareds)
            (cond
              [(is-var? le)
               (if (member? le declareds) le '*undeclared)]
              [(is-λ? le)
               (local ((define para (λ-para le))
                       (define body (λ-body le))
                       (define newd (cons para declareds)))
                 (make-λ-def para
                             (undeclareds/a body newd)))]
              [(is-app? le)
               (local ((define fun (app-fun le))
                       (define arg (app-arg le)))
                 (make-app
                  (undeclareds/a fun declareds)
                  (undeclareds/a arg declareds)))])))
    (undeclareds/a le0 '())))

(define ex5 (make-app (make-λ-def 'x 'x) 'x))
(check-expect (undeclareds ex5)
              (make-app (make-λ-def 'x 'x) '*undeclared))

(define ex6 (make-λ-def '*undeclared (make-app (make-λ-def 'x (make-app 'x '*undeclared))
                                              'y)))

(check-expect (undeclareds ex6)
              (make-λ-def '*undeclared (make-app (make-λ-def 'x (make-app 'x '*undeclared))
                                              '*undeclared)))
