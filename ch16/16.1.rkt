;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise246) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

(build-list 3 add1)

(filter odd? (list 1 2 3 4 5))

(sort (list 3 2 1 4 5) >)

(map add1 (list 1 2 2 3 3 3))

(andmap odd? (list 1 2 3 4 5))

(ormap odd? (list 1 2 3 4 5))

; [Number Number -> Number] Number -> [List-of Number]
(define (foldr func base lon)
  (cond
    [(empty? lon) base]
    [else
     (func (first lon)
           (foldr (rest lon)))]))
