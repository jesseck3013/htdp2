;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise426) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; [List-of Number] -> [List-of Number]
; produces a sorted version of alon
; assume the numbers are all distinct 
(define (quick-sort< alon)
  (cond
    [(empty? alon) '()]
    [(empty? (rest alon)) alon]
    [else (local ((define pivot (first alon)))
            (append (quick-sort< (smallers alon pivot))
                    (equals alon pivot)
                    (quick-sort< (largers alon pivot))))]))

; [List-of Number] Number -> [List-of Number]
; Create a list where all elements are from alon, and
; all elements are larger than n
(define (largers alon n)
  (cond
    [(empty? alon) '()]
    [else (if (> (first alon) n)
              (cons (first alon) (largers (rest alon) n))
              (largers (rest alon) n))]))

; [List-of Number] Number -> [List-of Number]
; Create a list where all elements are from alon, and
; all elements are smaller than n
(define (smallers alon n)
  (cond
    [(empty? alon) '()]
    [else (if (< (first alon) n)
              (cons (first alon) (smallers (rest alon) n))
              (smallers (rest alon) n))]))

; [List-of Number] Number -> [List-of Number]
; Create a list where all elements are from alon, and
; all elements are equal to n.
(define (equals alon n)
  (cond
    [(empty? alon) '()]
    [else (if (= (first alon) n)
              (cons (first alon) (equals (rest alon) n))
              (equals (rest alon) n))]))

(quick-sort< '(4 4 4 4 2 1))
; output: (1 2 4)

; Three 4s were dropped because the division phase only retrieve one 4, and thoes either larger or smaller than 4.
; The duplicate 4s were dropped at the division phase.

; To fix the issue, we also collect all the numbers that are equal to the pivot.
