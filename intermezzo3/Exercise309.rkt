#lang racket

; [List-of [List-of String]] -> [List-of Number]
(define (words-on-line llos)
  (match llos
    [(cons los '()) (list (length los))]
    [(cons los rst) (cons (length los)
                          (words-on-line rst))]))

(words-on-line (list (list "hello" "world")
                     (list "what" "is" "this")
                     (list "good" "day")))
