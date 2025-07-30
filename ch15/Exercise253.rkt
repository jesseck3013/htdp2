;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise246) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; [Number -> Boolean]
(number? 10)

; [Boolean String -> Boolean]
(check-expect (f #true "xx") #false)
(define (f b s)
  (and b (> (string-length s) 10)))

; [Number Number Number -> Number]
(check-expect (sum 1 2 3) 6)
(define (sum x y z)
  (+ x y z))

; [Number -> [List-of Number]]
(check-expect (create-list 3) (list 3 2 1))
(define (create-list n)
  (cond
    [(= n 0) '()]
    [else (cons n (create-list (sub1 n)))]))

; [[List-of Number] -> Boolean]
(check-expect (length-bigger-than-10 (list 1 2 3)) #false)
(define (length-bigger-than-10 l)
  (> (length l) 10))
