;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname data_info) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; A Color is one of: 
; — "white"
; — "yellow"
; — "orange"
; — "green"
; — "red"
; — "blue"
; — "black"

; ans:
; "white"
; "green"

; H is a Number between 0 and 100.
; interpretation represents a happiness value

; ans:
; 0
; 38
; 100

(define-struct person [fstname lstname male?])
; A Person is a structure:
;   (make-person String String Boolean)

; ans:
; (make-person "Bob" "John" #true)

(define-struct dog [owner name age happiness])
; A Dog is a structure:
;   (make-dog Person String PositiveInteger H)

; ans:
; (make-dog "Bob" "Doggy" 1 40)

; A Weapon is one of: 
; — #false
; — Posn
; interpretation #false means the missile hasn't 
; been fired yet; a Posn means it is in flight

; ans:
; #false
; (make-posn 30 40)
