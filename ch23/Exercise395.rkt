;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

;                  0      N
;  '()            '()    '()
;  (length > N)   '()    (item .... item(n-1))
;  (length <= N)   '()   entire list

; [X] [List-of X] N -> [List-of X]
(check-expect (take '() 0) '())
(check-expect (take '() 10) '())

(check-expect (take '(1) 0) '())
(check-expect (take '(1 2 3) 2) '(1 2))

(check-expect (take '(1 2 3) 0) '())
(check-expect (take '(1 2 3) 4) '(1 2 3))

(define (take l n)
  (cond
    [(= n 0) '()]
    [(<= (length l) n) l]
    [(> (length l) n)
     (cons (first l)
           (take (rest l) (sub1 n)))]))

;                  0       N
;  '()            '()     '()
;  (length > N)   l        (item(N) ....(item(length -1)))
;  (length <= N)  l       '()

; [X] [List-of X] N -> [List-of X]
(check-expect (drop '() 0) '())
(check-expect (drop '() 10) '())

(check-expect (drop '(1) 0) '(1))
(check-expect (drop '(1 2 3) 2) '(3))

(check-expect (drop '(1 2 3) 0) '(1 2 3))
(check-expect (drop '(1 2 3) 4) '())

(define (drop l n)
  (cond
    [(= n 0) l]
    [(< (length l) n) '()]
    [else 
     (drop (rest l) (sub1 n))]))
