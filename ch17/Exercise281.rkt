;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise265) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

(lambda (x) (< x 10))

(lambda (n1 n2) (number->string (* n1 n2)))

(lambda (n) (if (even? n)
                0
                1))

(define-struct IR [name price])
(lambda (ir1 ir2) (< (IR-price ir1)
                     (IR-price ir2)))

(define DOT (rectangle 10 10 "solid" "red"))
(lambda (p img) (place-image
                 DOT
                 (posn-x p)
                 (posn-y p)
                 img))
