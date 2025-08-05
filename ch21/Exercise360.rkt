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
