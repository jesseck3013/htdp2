#lang racket

(define (build-list-1 n)
  (for/list ([i n])
    i))

(build-list-1 10)

(define (build-list-2 n)
  (for/list ([i n])
    (add1 i)))

(build-list-2 10)

(define (build-list-3 n)
  (for/list ([i n])
    (/ 1 (add1 i))))

(build-list-3 10)

(define (build-list-4 n)
  (for/list ([i n])
    (* i 2)))

(build-list-4 10)

(define (build-list-5 n)
  (for/list ([row n])
    (for/list ([col n])
      ((lambda (cell)
         (if (= col row)
             1
             0)) col))))
(build-list-5 1)
(build-list-5 10)

; [X Y] [X -> Y] Number -> [List-of Y]
(define (tabulate func n)
  (for/list ([x n])
    (func x)))

(tabulate sin 10)
(tabulate number->string 10)
