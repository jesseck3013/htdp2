;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise246) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; List-of-numbers -> List-of-numbers
; converts a list of Celsius 
; temperatures to Fahrenheit 
(define (cf* l)
  (cond
    [(empty? l) '()]
    [else
     (cons
       (C2F (first l))
       (cf* (rest l)))]))

; Number -> Number
; converts one Celsius 
; temperature to Fahrenheit 
(define (C2F c)
  (+ (* 9/5 c) 32))

(define (map1 k g)
  (cond
    [(empty? k) '()]
    [else
     (cons
       (g (first k))
       (map1 (rest k) g))]))
	
(define (cf* l g)
  (cond
    [(empty? l) '()]
    [else
     (cons
       (g (first l))
       (cf* (rest l) g))]))

