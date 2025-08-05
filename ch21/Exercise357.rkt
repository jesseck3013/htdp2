;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise349) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define-struct add [left right])
(define-struct mul [left right])
(define-struct fun [name argument])

; A BSL-fun-expr is one of: 
; – Number
; – Symbol
; – (make-add BSL-fun-expr BSL-fun-expr)
; – (make-mul BSL-fun-expr BSL-fun-expr)
; - (make-fun Symbol BSL-fun-expr)

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

; BSL-fun-expr Symbol Symbol BSL-fun-expr
(check-expect (eval-definition1 10 'f 'x
                                (make-add 'x 10))
              10)

(check-error (eval-definition1 'x 'f 'x
                                (make-add 'x 10)))

(check-expect (eval-definition1
               (make-add 10 10) 'f 'x
               (make-add 'x 10))
              20)

(check-expect (eval-definition1
               (make-mul 10 10) 'f 'x
               (make-add 'x 10))
              100)

(check-expect (eval-definition1
               (make-fun 'f 10) 'f 'x
               (make-add 'x 10))
              20)

(check-expect (eval-definition1
               (make-fun 'f 10) 'f 'x
               (make-mul 'x 10))
              100)

(check-expect (eval-definition1
               (make-fun 'f (make-fun 'f 10)) 'f 'x
               (make-mul 'x 10))
              1000)

(define (eval-definition1 ex f x b)
  (cond
    [(number? ex) ex]
    [(symbol? ex) (error "Variable not defined")]
    [(add? ex) (+
                (eval-definition1 (add-left ex) f x b)
                (eval-definition1 (add-right ex) f x b))]
    [(mul? ex) (*
                (eval-definition1 (mul-left ex) f x b)
                (eval-definition1 (mul-right ex) f x b))]
    [(fun? ex)
       (if (equal? (fun-name ex) f)
           (local
               ((define value
                  (eval-definition1 (fun-argument ex) f x b))
                (define plugd
                     (subst b x value)))
             (eval-definition1 plugd f x b))
           (error "function not defined"))]))

;; Example input that makes the program do not stop.
;; (eval-definition1
;;  (make-fun 'f
;;            (make-fun 'f 10)) 'f 'x (make-fun 'f 'x))

