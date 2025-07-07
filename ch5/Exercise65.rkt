;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname data_info) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define-struct movie [title producer year])
; constructor: make-movie
; selectors: movie-title movie-producer movie-year
; predicates: movie?

(define-struct person [name hair eyes phone])
; constructor: make-person
; selectors: person-name person-hair person-eyes person-phone
; predicates: person?

(define-struct pet [name number])
; constructor: make-pet
; selectors: pet-name pet-number
; predicates: pet?

(define-struct CD [artist title price])
; constructor: make-CD
; selectors: CD-artist CD-title CD-price
; predicates: CD?

(define-struct sweater [material size producer])
; constructor: make-sweater
; selectors: sweater-material sweater-size sweater-producer
; predicates: sweater?
