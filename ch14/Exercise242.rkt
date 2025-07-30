;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |14.1|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; A [Maybe X] is one of: 
; – #false 
; – X

; [Maybe String] is one of:
; - #false
; - String

; [Maybe [List-of String]] is one of:
; - #false
; - [List-of String]

; [List-of [Maybe String]] is one of:
; - '()
; - (cons [Maybe String] [List-of [Maybe String]])

; String [List-of String] -> [Maybe [List-of String]]
; returns the remainder of los starting with s 
; #false otherwise 
(check-expect (occurs "a" (list "b" "a" "d" "e"))
              (list "d" "e"))
(check-expect (occurs "a" (list "b" "c" "d")) #f)
(define (occurs s los)
  (cond
     [(empty? los) #false]
     [(string=? s (first los)) (rest los)]
     [else (occurs s (rest los))]))

; the signatures means
; s is a String
; los is [List-of String] which can be either one of:
; - '()
; - (cons String [List-of String])

; the output is [Maybe [List-of String]] which can be either one of:
; - #false
; - [List-of String]
