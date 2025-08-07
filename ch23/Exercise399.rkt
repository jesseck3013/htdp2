;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; [NEList-of X] -> X 
; returns a random item from the list
(define example (list
                 (list "a" "b")
                 (list "b" "a")))
(check-random (random-pick example)
              (list-ref example (random (length example))))

(define (random-pick l)
  (list-ref l (random (length l))))

; [List-of String] [List-of [List-of String]] 
; -> 
; [List-of [List-of String]]
; produces the list of those lists in ll that do 
; not agree with names at any place
(check-expect (non-same (list "a" "b") (list
                              (list "a" "b")
                              (list "b" "a")))
              (list (list "b" "a")))
(define (non-same names ll)
  (cond
    [(empty? ll) '()]
    [(equal? names (first ll)) (non-same names (rest ll))]
    [else (cons (first ll) (non-same names (rest ll)))]))
