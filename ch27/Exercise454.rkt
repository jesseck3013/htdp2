;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |27.1|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; Number [List-of Number] -> [List-of [List-of Nubmer]]
(check-expect
 (create-matrix 2 (list 1 2 3 4))
 (list (list 1 2)
       (list 3 4)))

(check-expect
 (create-matrix 3 (list 1 2 3 4 5 6 7 8 9))
 (list (list 1 2 3)
       (list 4 5 6)
       (list 7 8 9)))

(check-expect
 (create-matrix 1 (list 1))
 (list (list 1 )))

(check-expect
 (create-matrix 0 '())
 '())

(define (create-matrix n lon)
  (cond
    [(empty? lon) '()]
    [else
     (cons (first-n n lon)
           (create-matrix n (rest-n n lon)))]))

; Number [List-of Number] -> [List-of Number]
(check-expect (first-n 2 (list 2 3)) (list 2 3))
(check-expect (first-n 2 (list 2 3 4 5)) (list 2 3))
(define (first-n n lon)
  (cond
    [(empty? lon) '()]
    [(= n 0) '()]
    [else (cons (first lon)
                (first-n (sub1 n) (rest lon)))]))

; Number [List-of Number] -> [List-f Nubmer]
(check-expect (rest-n 2 (list 2 3)) '())
(check-expect (rest-n 2 (list 2 3 4 5)) (list 4 5))

(define (rest-n n lon)
  (cond
    [(empty? lon) '()]
    [(= n 0) lon]
    [else (rest-n (sub1 n) (rest lon))]))
