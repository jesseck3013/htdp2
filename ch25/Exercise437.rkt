;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |25.1|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; Compute length
(define (special1 P)
  (local (
          (define (solve P) 0)
          (define (combine-solutions P rst)
            (+ 1 rst))
          )
  (cond
    [(empty? P) (solve P)]
    [else
     (combine-solutions
       P
       (special1 (rest P)))])))

(check-expect (special1 '()) 0)
(check-expect (special1 (list 1 2 3)) 3)

; negates each number on the list
(define (special2 P)
  (local (
          (define (solve P) '())
          (define (combine-solutions P rst)
            (cons (- (first P)) rst))
          )
  (cond
    [(empty? P) (solve P)]
    [else
     (combine-solutions
       P
       (special2 (rest P)))])))

(check-expect (special2 '()) '())
(check-expect (special2 (list 1 2 3)) (list -1 -2 -3))

; Uppercase the given list of strings
(define (special3 P)
  (local (
          (define (solve P) '())
          (define (combine-solutions P rst)
            (cons (string-upcase (first P)) rst))
          )
  (cond
    [(empty? P) (solve P)]
    [else
     (combine-solutions
       P
       (special3 (rest P)))])))

(check-expect (special3 '()) '())
(check-expect (special3 (list "hello" "world"))
              (list "HELLO" "WORLD"))

; Structural recursion is a special type of generative recursion.
