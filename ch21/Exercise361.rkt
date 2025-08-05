;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise349) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define-struct add [left right])
(define-struct mul [left right])
(define-struct fun [name argument])

; fun-def is a structure:
; (make-fun-def Symbol Symbol BSL-fun-expr)
(define-struct fun-def [name argument body])

; const-def is a structure:
; (make-const-def Symbol BSL-fun-expr)
(define-struct const-def [name body])

; A BSL-fun-expr is one of: 
; – Number
; – Symbol
; – (make-add BSL-fun-expr BSL-fun-expr)
; – (make-mul BSL-fun-expr BSL-fun-expr)
; - (make-fun Symbol BSL-fun-expr)

; BSL-da-all is a structure:
; (make-BSL-da-all AL [List-of fun-def])
(define-struct BSL-da-all [constants functions])

(define close-to-pi (make-const-def
                     'close-to-pi
                     3.14))

(define area-of-circle
  (make-fun-def
   'area-of-circle
   'r
   (make-mul 'close-to-pi (make-mul 'r 'r))))

(define volume-of-10-cylinder
  (make-fun-def
   'volume-of-10-cylinder
   'r
   (make-mul 10
             (make-fun 'area-of-circle 'r))))

(define da-all
  (make-BSL-da-all (list close-to-pi)
                   (list area-of-circle
                         volume-of-10-cylinder)))

; BSL-da-all Symbol -> const-def
(check-error (lookup-con-def da-all 'x))
(check-expect (lookup-con-def da-all 'close-to-pi)
              close-to-pi)
(define (lookup-con-def da s)
  (local
      (
       (define const-l (BSL-da-all-constants da))

       ; [List-of const-def] -> const-def
       (define (lookup l)
         (cond
           [(empty? l) (error "vairable undefined")]
           [(equal?
             (const-def-name (first l)) s)
            (first l)]
           [else (lookup (rest l))])))
    (lookup const-l)))

; BSL-da-all Symbol -> fun-def
(check-error (lookup-fun-def da-all 'z))
(check-expect (lookup-fun-def da-all 'area-of-circle)
              area-of-circle)
(check-expect (lookup-fun-def da-all 'volume-of-10-cylinder)
             volume-of-10-cylinder)

(define (lookup-fun-def da s)
  (local
      (
       (define fun-l (BSL-da-all-functions da))

       ; [List-of fun-def] -> fun-def
       (define (lookup l)
         (cond
           [(empty? l) (error "function undefined")]
           [(equal?
             (fun-def-name (first l)) s)
            (first l)]
           [else (lookup (rest l))])))
  (lookup fun-l)))

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

; BSL-fun-expr BSL-da-all -> Number
(check-expect (eval-all 10 da-all) 10)

(check-expect (eval-all 'close-to-pi da-all) 3.14)
(check-error (eval-all 'x da-all))

(check-expect (eval-all (make-add 10 10) da-all) 20)
(check-expect (eval-all (make-mul 10 10) da-all) 100)

(check-within (eval-all               
               (make-fun 'volume-of-10-cylinder 1) da-all)
              31.40
              0.01)

(check-within (eval-all               
               (make-mul 3 'close-to-pi) da-all)
              9.42
              0.01)


(define (eval-all expr da)
  (cond
    [(number? expr) expr]
    [(symbol? expr)
     (local (
             (define const (lookup-con-def da expr))
             (define const-body (const-def-body const))
             )
     (eval-all const-body da))]
    [(add? expr)
     (+ (eval-all (add-left expr) da)
        (eval-all (add-right expr) da))]
    [(mul? expr)
     (* (eval-all (mul-left expr) da)
        (eval-all (mul-right expr) da))]
    [(fun? expr)
     (local (
             (define def (lookup-fun-def da (fun-name expr)))

              (define arg-value
                (eval-all (fun-argument expr) da))
              
              (define plugd
                (subst (fun-def-body def)
                       (fun-def-argument def)
                       arg-value))
              )
       (eval-all plugd da))]))
