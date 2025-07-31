;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise246) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))



; [X] Number [Number -> X] -> [List-of X]
(check-expect (build-l*st 10 add1)
              (build-list 10 add1))
(check-expect (build-l*st 10 number->string)
              (build-list 10 number->string))
(define (build-l*st n func)
  (cond
    [(= n 0) '()]
    [else (add-at-end (func (sub1 n))
                      (build-l*st (sub1 n) func))]))

; [X] X [List-of X] -> [List-of X]
(check-expect (add-at-end 10 (list 1 2 3))
              (list 1 2 3 10))
(define (add-at-end item loi)
  (cond
    [(empty? loi) (list item)]
    [else (cons (first loi)
                (add-at-end item (rest loi)))]))
