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

; BSL-fun-expr Symbol Number -> BSL-fun-expr
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
                         (subst (mul-right ex) x v))]
    [(fun? ex) (make-fun (fun-name ex)
                         (subst (fun-argument ex) x v))]))

; BSL-fun-expr BSL-fun-def* -> Number
(check-expect
 (eval-function* 10 da-fgh) 10)

(check-error
 (eval-function* 'x da-fgh))

(check-expect
 (eval-function* (make-add 10 10) da-fgh) 20)

(check-expect
 (eval-function* (make-mul 10 10) da-fgh) 100)

(check-expect
 (eval-function* (make-fun 'f 10) da-fgh) 13)

(check-expect
 (eval-function* (make-fun 'g 10) da-fgh) 23)

(check-expect
 (eval-function* (make-fun 'h 10) da-fgh) 36)

(check-error
 (eval-function* (make-fun 'z 10) da-fgh))

(define (eval-function* ex da)
  (cond
    [(number? ex) ex]
    [(symbol? ex) (error "variable undefined")]
    [(add? ex)
     (+
      (eval-function* (add-left ex) da)
      (eval-function* (add-right ex) da))]
    [(mul? ex)
     (*
      (eval-function* (mul-left ex) da)
      (eval-function* (mul-right ex) da))]
    [(fun? ex)
     (local
         (
          (define def
            (lookup-def da (fun-name ex)))
          
          (define arg-value
            (eval-function* (fun-argument ex) da))
 
          (define plugd
            (subst (fun-def-body def)
                   (fun-def-argument def)
                   arg-value)))
       (eval-function* plugd da))]))
