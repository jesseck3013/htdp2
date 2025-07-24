;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise97) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; NEList-of-temperatures -> Number
; computes the average temperature 
 
(check-expect (average (cons 1 (cons 2 (cons 3 '()))))
              2)
 
(define (average ne-l)
  (/ (sum ne-l)
     (how-many ne-l)))

(define (sum ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [else (+ (first ne-l) (sum (rest ne-l)))]))

; NEList-of-temperatures -> Number
; compute the number of elements in the list ne-l
(check-expect (how-many (cons 1 '())) 1)
(check-expect (how-many (cons 2(cons 1 '()))) 2)
(define (how-many ne-l)
  (cond
    [(empty? (rest ne-l)) 1]
    [else (+ 1 (how-many (rest ne-l)))]))
