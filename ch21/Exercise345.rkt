;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |20.3|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define-struct add [left right])
(define-struct mul [left right])

(+ 10 -10)
(make-add 10 -10)

(+ (* 20 3) 33)
(make-add (make-mul 20 3) 30)

(+ (* 3.14 (* 2 3)) (* 3.14 (* -1 -9)))
(make-add
 (make-mul 3.14 (make-mul 2 3))
 (make-mul 3.14 (make-mul -1 -9)))

(make-add -1 2)
(+ -1 2)

(make-add (make-mul -2 -3) 33)
(+ (* -2 -3) 33)

(make-mul (make-add 1 (make-mul 2 3)) 3.14)
(* (+ 1 (* 2 3)) 3.14)
