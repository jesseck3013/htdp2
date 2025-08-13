;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |33.1|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; A Lam is one of: 
; – a Symbol
; – (list 'λ (list Symbol) Lam)
; – (list Lam Lam)

(define ex1 '(λ (x) x))
(define ex2 '(λ (x) y))
(define ex3 '(λ (y) (λ (x) y)))
(define ex4 '((λ (x) (x x)) (λ (x) (x x))))

; Lam -> Boolean
(check-expect (is-var? 'x) #true)
(check-expect (is-var? ex1) #false)
(define (is-var? x)
  (symbol? x))

; Lam -> Boolean
(check-expect (is-λ? 'x) #false)
(check-expect (is-λ? ex1) #true)
(check-expect (is-λ? ex2) #true)
(check-expect (is-λ? ex3) #true)
(check-expect (is-λ? ex4) #false)
(define (is-λ? l)
  (cond
    [(is-var? l) #false]
    [else (equal? (first l) 'λ)]))

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

; Lam -> (List Symbol)
(check-expect (λ-para ex1) '(x))
(define (λ-para l)
  (second l))

; Lam -> Lam
(check-expect (λ-body ex1) 'x)
(check-expect (λ-body ex2) 'y)
(define (λ-body l)
  (third l))

; Lam -> Lam
(check-expect (app-fun ex4) '(λ (x) (x x)))
(define (app-fun l)
  (first l))

; Lam -> Lam
(check-expect (app-arg ex4) '(λ (x) (x x)))
(define (app-arg l)
  (second l))

; Lam -> [List-of symbols]
(define (declareds l)
  (cond
    [(is-var? l) '()]
    [(is-λ? l) (append (λ-para l)
                       (declareds (λ-body l)))]
    [else (append (declareds (first l))
                  (declareds (second l)))]))

(check-expect (declareds ex1) '(x))
(check-expect (declareds ex2) '(x))
(check-expect (declareds ex3) '(y x))
(check-expect (declareds ex4) '(x x))

