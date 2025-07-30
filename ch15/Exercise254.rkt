;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise246) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; [List-of Number] [Number Number -> Boolean] -> [List-of Number]
(define (sort-n lon func) lon)

; [List-of String] [String String -> Boolean] -> [List-of String]
(define (sort-s los func) los)

; Corresponding parts:
; 1. Number -> String

; [X] [List-of X] [X X -> Boolean] -> [List-of X]

; To describe a sort function for lists of IRs
; 1. replace X with IR

; [List-of IR] [IR IR -> Boolean] -> [List-of IR]
