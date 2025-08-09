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
    [else (local (
                  (define pivot (first alon))
                  (define smallers-list (smallers alon pivot))
                  (define largers-list
                    (filter (lambda (item)
                              (and (not (= item pivot))
                                   (not
                                    (member? item smallers-list))))
                                   alon))
                  )
            (append (quick-sort< smallers-list)
                    (list pivot)
                    (quick-sort< largers-list)))]))

; [List-of Number] Number -> [List-of Number]
; Create a list where all elements are from alon, and
; all elements are smaller than n
(define (smallers alon n)
  (filter (lambda (item)
            (< item n)) alon))

(quick-sort< '(8 10 4 1))
