;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |11|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; Exercise 145:
; NEList-of-temperatures -> Boolean
; output #true when numbers in ne-l are in a descending order
(check-expect (sorted>? (cons 1 '())) #true)
(check-expect (sorted>? (cons 2 (cons 1 '()))) #true)
(check-expect (sorted>? (cons 1 (cons 2 '()))) #false)
(define (sorted>? ne-l)
  (cond
    [(empty? (rest ne-l)) #true]
    [else (if (> (first ne-l)
                 (first (rest ne-l)))
              (sorted>? (rest ne-l))
              #false)]))

; List-of-numbers -> List-of-numbers
; produces a sorted version of alon
(check-expect (sort> '()) '())
(check-satisfied (sort> (list 3 4 1 2)) sorted>?)
(define (sort> alon)
  (cond
    [(empty? alon) '()]
    [else (insert> (sort> (rest alon)) (first alon))]))

; List-of-numbers Number -> List-of-numbers
; insert a number into a sorted list
; the output keeps the sorted order
(check-expect (insert> '() 3) (list 3))
(check-expect (insert> (list 4 2 1) 3) (list 4 3 2 1))
(define (insert> sorted-loa n)
  (cond
    [(empty? sorted-loa) (cons n '())]
    [(< n (first sorted-loa))
     (cons (first sorted-loa)
           (insert>
            (rest sorted-loa) n))]
    [(>= n (first sorted-loa)) (cons n sorted-loa)]))

(define (my-sorted l)
  (equal? (list 4 3 2 1) l))

; List-of-numbers -> List-of-numbers
; produces a sorted version of l
;(check-expect (sort>/bad (list 1 2 3 4)) (list 4 3 2 1))
(check-satisfied (list 3 2 4 1) my-sorted)
(define (sort>/bad l)
  (list 9 8 7 6 5 4 3 2 1 0))
