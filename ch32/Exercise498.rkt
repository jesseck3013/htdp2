;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise489) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define-struct node [left right])

; Tree N N -> N
; measures the height of abt
; accumulator s is the number of steps 
; it takes to reach abt from abt0
; accumulator m is the maximal height of
; the part of abt0 that is to the left of abt
(define (h/a abt s m)
  (cond
    [(empty? abt) (max s m)]
    [else
     (h/a (node-right abt) s (h/a (node-left abt) (add1 s) m))]))

(define example1
  (make-node (make-node '() (make-node '() '())) '()))

(define example2
  (make-node '() '()))

(check-expect (h/a '() 0 0) 0)
(check-expect (h/a example1 0 0) 2)
(check-expect (h/a example2 0 0) 1)

(define (height.v3 tree)
  (h/a tree 0 0))

(check-expect (height.v3 '()) 0)
(check-expect (height.v3 example1) 2)
(check-expect (height.v3 example2) 1)
