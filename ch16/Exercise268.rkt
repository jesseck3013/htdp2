;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise265) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; An IR is a strucutre:
; (make-IR String String Number Number)
(define-struct IR [name description cost retail-price])

; [List-of IR] -> [List-of IR]
(check-expect (sort-IRs
               (list
                (make-IR "phones" "phones" 1000 1200)
                (make-IR "noodle" "noodle" 10 15)
                (make-IR "pen" "pen" 1 3)))
              (list
               (make-IR "pen" "pen" 1 3)
               (make-IR "noodle" "noodle" 10 15)
               (make-IR "phones" "phones" 1000 1200)))

(define (sort-IRs loir)
  (local (
          ; IR -> Number
          (define (difference ir)
            (-
             (IR-retail-price ir)
             (IR-cost ir)))

          ; IR IR -> Boolean
          (define (cmp ir1 ir2)
            (< (difference ir1)
               (difference ir2)))
          )
    (sort loir cmp)))
