;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise153) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; List-of-posns -> Number
; sum of all of a list's x-coordinates 
(check-expect (sum '()) 0)
(check-expect (sum (cons (make-posn 1 1) '())) 1)
(check-expect (sum (cons (make-posn 10 1)
                         (cons (make-posn 1 1) '()))) 11)
(define (sum lop)
  (cond
    [(empty? lop) 0]
    [else (+ (posn-x (first lop))
             (sum (rest lop)))]))
