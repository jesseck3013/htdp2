;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise153) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define EXCHANGE-RATE 1.18)
; Number -> Number
(check-expect (euro-to-usd 0) 0)
(check-expect (euro-to-usd 1) EXCHANGE-RATE)
(check-expect (euro-to-usd 2) (* 2 EXCHANGE-RATE))
(define (euro-to-usd e)
  (* e EXCHANGE-RATE))

; List-of-numbers is one of
; - '()
; - (cons Number List-of-numbers)

; List-of-numbers -> List-of-numbers
(check-expect (convertEuro '()) '())
(check-expect (convertEuro (cons 0 '())) (cons 0 '()))
(check-expect (convertEuro (cons 1 (cons 2 '()))) (cons EXCHANGE-RATE (cons (* 2 EXCHANGE-RATE) '())))
(define (convertEuro f)
  (cond
    [(empty? f) '()]
    [else (cons (euro-to-usd (first f))
                 (convertEuro (rest f)))]))
