;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise153) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; A Matrix is one of: 
;  – (cons Row '())
;  – (cons Row Matrix)
; constraint all rows in matrix are of the same length
 
; A Row is one of: 
;  – '() 
;  – (cons Number Row)

(define row1 (cons 11 (cons 12 '())))
(define row2 (cons 21 (cons 22 '())))
(define mat1 (cons row1 (cons row2 '())))

;; [11 12]
;; [21 22]
;; transpose
;; [11 21]
;; [12 22]

; Matrix -> Matrix
; transposes the given matrix along the diagonal 
(define wor1 (cons 11 (cons 21 '())))
(define wor2 (cons 12 (cons 22 '())))
(define tam1 (cons wor1 (cons wor2 '()))) 

(check-expect (transpose mat1) tam1)
 
(define (transpose lln)
  (cond
    [(empty? (first lln)) '()]
    [else (cons (first* lln) (transpose (rest* lln)))]))

; Matrix -> List-of-numbers
(check-expect (first* mat1) (cons 11 (cons 21 '())))
(check-expect (first* tam1) (cons 11 (cons 12 '())))
(define (first* m)
  (cond
    [(empty? m) '()]
    [else
     (cons (first (first m))
           (first* (rest m)))]))

; Matrix -> Matrix
(check-expect (rest* mat1) (cons
                            (cons 12 '())
                            (cons 
                             (cons 22 '()) '())))
(check-expect (rest* tam1) (cons
                            (cons 21 '())
                            (cons 
                             (cons 22 '()) '())))
(define (rest* m)
  (cond
    [(empty? m) '()]
    [else
     (cons 
      (remove-first (first m))
      (rest* (rest m)))]))

; List-of-Number -> List-of-Number
(check-expect (remove-first '())
              '())
(check-expect (remove-first (cons 1 (cons 2 '())))
              (cons 2 '()))
(check-expect (remove-first (cons 3 (cons 1 (cons 2 '()))))
              (cons 1 (cons 2 '())))

(define (remove-first lon)
  (cond
    [(empty? lon) '()]
    [else
     (rest lon)]))

; Q1: Why does transpose ask (empty? (first lln))?
; Matrix is a self-referential data type.
; Its non-self-referential case is (cons Row '()).
; (empty? (first lln)) is essentially checking if Row is empty

; Q2: Why is it impossible to develop Transpose with the design recipe.
; Design recipe is for natural recursion.
; Transpose is not natural recursion,
; because it does not go through the data Row by Row.


