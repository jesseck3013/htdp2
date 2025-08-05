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

; BSL-Expr -> Number
; Evaluate the given BSL-Expr to a number.
(check-expect (eval-expression 10) 10)
(check-expect (eval-expression (make-add 1 1)) 2)
(check-expect (eval-expression (make-mul 2 3)) 6)
(check-expect (eval-expression
               (make-add 1 (make-mul 2 3))) 7)

(define (eval-expression expr)
  (cond
    [(number? expr) expr]
    [(add? expr) (+ (eval-expression (add-left expr))
                    (eval-expression (add-right expr)))]
    [(mul? expr) (* (eval-expression (mul-left expr))
                    (eval-expression (mul-right expr)))]))

; BSL-var-expr -> Number
; Evaluate the expression if (numeric? s) is #true
; Otherwise, signal an error
(check-error (eval-variable 'x))
(check-expect (eval-variable 10) 10)
(check-expect (eval-variable
               (make-add 10 10)) 20)
(check-expect (eval-variable
               (make-mul 10 10)) 100)
(check-error (eval-variable
               (make-mul 10 'x)))

(define
  (eval-variable s)
  (if (numeric? s)
      (eval-expression s)
      (error "The given expression is not numeric.")))

; BSL-var-expr Symbol Number -> BSL-var-expr
(check-expect (subst 10 'x 10) 10)
(check-expect (subst 'x 'x 10) 10)
(check-expect (subst (make-add 'x 10) 'x 10)
              (make-add 10 10))
(check-expect (subst (make-mul 'x 10) 'x 10)
              (make-mul 10 10))

(define (subst ex x v)
  (cond
    [(number? ex) ex]
    [(symbol? ex) (if (equal? ex x)
                      v
                      ex)]
    [(add? ex) (make-add (subst (add-left ex) x v)
                         (subst (add-right ex) x v))]
    [(mul? ex) (make-mul (subst (mul-left ex) x v)
                         (subst (mul-right ex) x v))]))

; An AL (short for association list) is [List-of Association].
; An Association is a list of two items:
;   (cons Symbol (cons Number '())).

; BSL-var-expr AL -> Number
(define AL (list
            (list 'x 100)
            (list 'y 30)))

(check-expect
 (eval-variable* 10 AL) 10)

(check-expect
 (eval-variable* 'x AL) 100)

(check-error
 (eval-variable* 'z AL))

(check-expect
 (eval-variable* (make-add 'x 10) AL) 110)

(check-expect
 (eval-variable* (make-mul 'x 10) AL) 1000)

(check-expect
 (eval-variable* (make-add 'x 'y) AL) 130)

(check-expect
 (eval-variable* (make-add 'x
                           (make-add 'x 'x)) AL)
 300)

; BSL-var-expr AL -> BSL-var-expr
; replace symbol with its corresponding value in AL
(check-expect (subst* (make-add 'x 'y) AL) (make-add 100 30))
(define (subst* ex da)
  (cond
    [(empty? da) ex]
    [else
     (subst*
      (subst ex
             (first (first da))
             (second (first da)))
      (rest da))]))

; BSL-var-expr -> Number
; 1. replace symbols with their corresponding value in AL
; 2. if (numerics? ex) is #true, evaluate the expression
; 3. if not #true, signal error.
(define (eval-variable* ex da)
  (eval-variable (subst* ex da)))
