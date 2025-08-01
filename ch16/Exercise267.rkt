;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise265) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; [List-of Number] -> [List-of Number]
; convert a list of US$ amonts into euro amounts
; based on US$ 1.06 = 1 euro
(check-expect (convert-euro (list 1.06 10.6 106))
              (list 1 10 100))

(define (convert-euro lusd)
  (local (
          (define (usd-to-euro amount)
            (/ amount 1.06))
          )
    (map usd-to-euro lusd)))


; [List-of Number] -> [List-of Number]
; convert a list of Fahrenheit measurements to a list of Celsius measurements.
(check-expect (convertFC (list 32 86))
              (list 0 30))

(define (convertFC lfc)
  (local (
          (define (fc-to-cel f)
            (/ (- f 32) (/ 9 5))
          ))
    (map fc-to-cel lfc)))

; [List-of Posn] -> [List-of [List-of pair]]
(check-expect (translate (list
                          (make-posn 0 0)
                          (make-posn 1 1)
                          (make-posn 2 2)))
              (list
               (list 0 0)
               (list 1 1)
               (list 2 2)))

(define (translate lop)
  (local (
          (define (to-pair p)
            (list (posn-x p)
                  (posn-y p)))
          )
    (map to-pair lop)))
