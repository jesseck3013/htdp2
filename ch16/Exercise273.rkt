;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise265) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; [X Y] [X -> Y] [List-of X] -> [List-of Y]
(check-expect (map-from-fold add1 (list 1 2 3))
              (map add1 (list 1 2 3)))
(check-expect (map-from-fold sub1 (list 1 2 3))
              (map sub1 (list 1 2 3)))
(define (map-from-fold func l)
  (local (
          ; [X Y -> Y]
          (define (helper x y)
            (cons (func x) y))
          )
    (foldr helper '() l)))
