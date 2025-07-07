;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname data_info) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; String String Number 
(define-struct movie [title producer year])
(make-movie "Spider Man" "Producer" 1995)

; String String String String 
(define-struct person [name hair eyes phone])
(make-person "Bob" "black" "black" "123-456-789")

; String Number
(define-struct pet [name number])
(make-pet "Doggy" 1)

; String String Number
(define-struct CD [artist title price])
(make-pet "Beatles" "Song" 3)

; String String String
(define-struct sweater [material size producer])
(make-sweater "cotton" "S" "sweater producer")

