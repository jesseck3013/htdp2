;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; [X Y] [X Y -> Boolean] [List-of X] [List-of Y] -> Boolean
(define (andmap2 f l1 l2)
  (cond
    [(empty? l1) #true]
    [else
     (and (f (first l1) (first l2))
          (andmap2 f (rest l1) (rest l2)))]))

(check-expect (andmap2 equal? '(1 2 3) '(1 2 3)) #true)
(check-expect (andmap2 equal? '(1 2 3) '("1" 2 3)) #false)
