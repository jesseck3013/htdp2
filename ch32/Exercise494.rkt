;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise489) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; List-of-numbers -> List-of-numbers
; produces a sorted version of l
(define (sort> l)
  (cond
    [(empty? l) '()]
    [(cons? l) (insert (first l) (sort> (rest l)))]))
 
; Number List-of-numbers -> List-of-numbers
; inserts n into the sorted list of numbers l 
(define (insert n l)
  (cond
    [(empty? l) (cons n '())]
    [else (if (>= n (first l))
              (cons n l)
              (cons (first l) (insert n (rest l))))]))

; input size  0
; sort>       0 insert
; insert      0

; input size  1
; sort>       1 insert
; insert      0

; input size  2
; sort>       2 insert
; insert      1

; input size  n
; sort>       n insert
; insert      n - 1

; sort> belongs to O(n^2)


; List-of-numbers -> List-of-numbers
; produces a sorted version of l
(define (sort>/acc l)
  (local ((define (helper unsorted sorted)
            (cond
              [(empty? unsorted) sorted]
              [else
               (helper (rest unsorted)                       
                       (insert (first unsorted)
                            sorted))]))
          )
    (helper l '())))
        
(check-expect (sort>/acc (list 2 4 8 1 3))
              (list 8 4 3 2 1))

; input size: 0
; helper:     0 insert
; insert:     0

; input size: 1
; helper:     1 insert
; insert:     0

; input size: 2
; helper:     2 insert
; insert:     1

; input size: n
; helper:     n insert
; insert:     n - 1

; helper still belongs to O(n^2) even with an accumulator.
