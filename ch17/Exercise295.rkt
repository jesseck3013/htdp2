;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise265) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; distances in terms of pixels 
(define WIDTH 300)
(define HEIGHT 300)
 
; N -> [List-of Posn]
; generates n random Posns in [0,WIDTH) by [0,HEIGHT)
(check-satisfied (random-posns 3)
                 (n-inside-playground? 3))
(define (random-posns n)
  (build-list
    n
    (lambda (i)
      (make-posn (random WIDTH) (random HEIGHT)))))

; Number -> Boolean
(define (n-inside-playground? n)
  (lambda (lop)
    (cond
      [(not (= (length lop) n)) #false]
      [else
       (andmap (lambda (p)
                 (and
                  (<= 0 (posn-x p) WIDTH)
                  (<= 0 (posn-y p) HEIGHT)))
               lop)])))

; N -> [List-of Posn]
; generate n (1, 1) posns (not random)
(define (random-posns/bad n)
  (cond
    [(= n 0) '()]
    [else (cons (make-posn 1 1)
                (random-posns/bad (sub1 n)))]))
(check-satisfied (random-posns/bad 3)
                 (n-inside-playground? 3))
