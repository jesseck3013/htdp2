;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise97) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; list-of-booleans -> Boolean
(check-expect (all-true '()) #true)
(check-expect (all-true (cons #true '())) #true)
(check-expect (all-true (cons #false (cons #true '()))) #false)
(define (all-true lob)
  (cond
    [(empty? lob) #true]
    [else
     (if (first lob)
         (all-true (rest lob))
         #false)]))

; list-of-booleans -> Boolean
(check-expect (one-true '()) #false)
(check-expect (one-true (cons #true '())) #true)
(check-expect (one-true (cons #true (cons #true '()))) #true)
(check-expect (one-true (cons #false (cons #false '()))) #false)
(define (one-true lob)
  (cond
    [(empty? lob) #false]
    [else
     (if (first lob)
         #true
         (one-true (rest lob)))]))
