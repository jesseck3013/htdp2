;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; [List-of Nubmer] [List-of Number] -> [List-of Number]
; merge two sorted list into one
(check-expect (merge '() '()) '())
(check-expect (merge '(1 2 3) '()) '(1 2 3))
(check-expect (merge '() '(4 5 6)) '(4 5 6))
(check-expect (merge '(1 2 3) '(4 5 6)) '(1 2 3 4 5 6))

(check-expect (merge '(1 2 10) '(4 5 6)) '(1 2 4 5 6 10))

(define (merge l1 l2)
  (cond
    [(empty? l1) l2]
    [(empty? l2) l1]
    [(and (not (empty? l1)) (not (empty? l2)))
     (if (< (first l1) (first l2))
         (cons (first l1)
               (merge (rest l1) l2))
         (cons (first l2)
               (merge l1 (rest l2))))]))
