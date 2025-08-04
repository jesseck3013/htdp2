#lang racket

(define-struct phone [area switch four])
; A Phone is a structure: 
;   (make-phone Three Three Four)
; A Three is a Number between 100 and 999. 
; A Four is a Number between 1000 and 9999. 

(define (replace p)
  (match p
    [(phone area switch four)
     (if (= area 713)
         (make-phone 281 switch four)
         p)]))

(phone-area (replace (make-phone 713 222 3333)))
(phone-area (replace (make-phone 714 222 3333)))

