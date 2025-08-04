#lang racket

(match 10
  [10 #true])

(match 10
  [100 #true]
  [(cons x '()) (* x 2)]
  [x (* x 10)])

; A [Non-empty-list X] is one of: 
; – (cons X '())
; – (cons X [Non-empty-list X])
(define (last-item nel)
  (match nel
    [(cons x '()) x]
    [(cons x y) (last-item  y)]))

(last-item (list 1 2 3 4 5))

(define-struct layer [color doll])
; An RD.v2 (short for Russian doll) is one of: 
; – "doll"
; – (make-layer String RD.v2)

(define (depth rd)
  (match rd
    ["doll" 0]
    [(layer name inner-layer) (+ 1 (depth inner-layer))]))

(depth (make-layer "red"
                   (make-layer "blue"
                               (make-layer "yello" "doll"))))
(depth "doll")
