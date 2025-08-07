;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; A Son.L is one of: 
; – empty 
; – (cons Number Son.L)
; 
; Son is used when it 
; applies to Son.L and Son.R
	
; Son.L Son.L -> Son.L
(check-expect (union (list 1 2 3) (list 4 5 6))
              (list 1 2 3 4 5 6))

(check-expect (union '() (list 4 5 6))
              (list 4 5 6))

(check-expect (union '(1) '())
              (list 1))

(check-expect (union '() '())
              '())

(define (union s1 s2)
  (cond
    [(empty? s1) s2]
    [else (cons (first s1)
                (union (rest s1) s2))]))

; Son.L Son.L -> Son.L
(define (intersec s1 s2)
  (cond
    [(or
      (empty? s1) (empty? s2)) '()]
    [(and
      (not (empty? s1)) (not (empty? s2)))
     (if (member? (first s1) s2)
         (cons (first s1)
               (intersec (rest s1) s2))
         (intersec (rest s1) s2))]))

(check-expect (intersec (list 1 2 3) '()) '())
(check-expect (intersec '() (list 1 2 3)) '())
(check-expect (intersec (list 1 2 3) (list 4 5 6)) '())
(check-expect (intersec (list 1 2 3) (list 1 5 6)) '(1))
(check-expect (intersec (list 1 1 3) (list 1 5 6)) '(1 1))
