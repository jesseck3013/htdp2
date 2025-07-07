;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname data_info) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; movie is (make-movie String String Number)
(define-struct movie [title producer year])

; person is (make-person String String String Number)
(define-struct person [name hair eyes phone])

; pet is (make-person String Number)
(define-struct pet [name number])

; CD is (make-CD String String Number)
(define-struct CD [artist title price])

; sweater is (make-sweater String String String)
(define-struct sweater [material size producer])
