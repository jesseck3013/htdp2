;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise298) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; a set is a function
; [X] [X -> Boolean]

; [X] [X -> Boolean] -> set
(define (create-set rule)
  (lambda (x)
    (rule x)))
(check-expect ((create-set even?) 10) #true)
(check-expect ((create-set even?) 1) #false)

; [X] X set -> set
(define (add-element x s)
  (lambda (n)
    (or (equal? x n)
        (s n))))

(check-expect ((add-element 1 (create-set even?)) 10)
              #true)
(check-expect ((add-element 1 (create-set even?)) 3)
              #false)
(check-expect ((add-element 1 (create-set even?)) 1)
              #true)

; set set -> set
(define (union s1 s2)
  (lambda (n)
    (or (s1 n) (s2 n))))

(check-expect ((union
               (create-set even?)
               (create-set odd?)) 10)
              #true)
(check-expect ((union
               (create-set even?)
               (create-set odd?)) 1)
              #true)

; set set -> set
(define (intersect s1 s2)
  (lambda (n)
    (and (s1 n) (s2 n))))

(check-expect ((intersect
               (create-set even?)
               (create-set odd?)) 10)
              #false)
(check-expect ((intersect
               (create-set even?)
               (create-set odd?)) 1)
              #false)
