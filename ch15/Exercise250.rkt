;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise246) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; [Number -> Number] Number -> [List-of Number]
(define (tabulate func n)
  (cond
    [(= n 0) (list (func 0))]
    [else
     (cons
      (func n)
      (tabulate func (sub1 n)))]))

; Number -> [List-of Number]
(check-within
 (tab-sin 3)
 (list (sin 3) (sin 2) (sin 1) (sin 0))
 0.01)
(define (tab-sin n)
  (tabulate sin n))

; Number -> [List-of Number]
(check-within
 (tab-sqrt 3)
 (list (sqrt 3) (sqrt 2) (sqrt 1) (sqrt 0))
 0.01)
(define (tab-sqrt n)
  (tabulate sqrt n))

; Number -> [List-of Number]
; tabulates sqr betwen n and 0 in a list
(check-expect (tab-sqr 3) (list 9 4 1 0))
(define (tab-sqr n)
  (tabulate sqr n))

; Number -> [List-of Number]
; tabulates tan betwen n and 0 in a list
(check-within
 (tab-tan 3)
 (list (tan 3) (tan 2) (tan 1) (tan 0))
 0.01)
(define (tab-tan n)
  (tabulate tan n))
