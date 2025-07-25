;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |11|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define List1
  (cons "a" (cons "b" (cons "c" (cons "d" '())))))
(define List2
  (cons (cons 1 (cons 2 '())) '()))
(define List3
  (cons "a" (cons (cons 1 '()) (cons #false '()))))
(define List4
  (cons (cons "a" (cons 2 '())) (cons "hello" '())))

(check-expect (list "a" "b" "c" "d") List1)
(check-expect (list (list 1 2)) List2)
(check-expect (list "a" (list 1)  #false) List3)
(check-expect (list (list "a" 2) "hello") List4)

(define List5
  (cons (cons 1 (cons 2 '()))
        (cons (cons 2 '())
              '())))

(check-expect (list (list 1 2) (list 2)) List5)


