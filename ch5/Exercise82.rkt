;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname data_info) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; letter is one of:
; - 1String "a" through "z"
; - #false

; word is a structure:
; (make-word letter letter letter)
(define-struct word [first second third])

; example
;(make-word #false "a" "b")
;(make-word "a" "b" "c")

(define w1 (make-word "a" "b" "c"))
(define w2 (make-word "a" "b" "d"))

(check-expect (compare-word w1 w1) w1)
(check-expect (compare-word w1 w2) #false)

(define (compare-word w1 w2)
  (if (and 
       (equal? (word-first w1) (word-first w2))
       (equal? (word-second w1) (word-second w2))
       (equal? (word-third w1) (word-third w2)))
      w1
      #false))
