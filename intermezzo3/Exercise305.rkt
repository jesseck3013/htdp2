#lang racket

; [List-of Number] -> [List-of Number]
; convert a list of US$ amonts into euro amounts
; based on US$ 1.06 = 1 euro
;; (check-expect (convert-euro (list 1.06 10.6 106))
;;               (list 1 10 100))

(define (convert-euro lusd)
  (for/list ([usd lusd])
     (/ usd 1.06)))

(convert-euro (list 1.06 10.6 106))
