;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise97) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; 1. x
; x is a variable 
; variable is valid expr

; 2. (= y z)
; = is primitive; y is variable; z is variable
; it is valid according to expr = (primitive expr expr ...)

; 3. (= (= y z) 0)
; according to 2, (= y z) is vaild expr
; 3 can be transformed into  (= expr 0)
; which is (primitive expr value)
; which is (primitive expr expr)

