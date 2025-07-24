;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise153) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; Number -> Number
(check-expect (F-TO-C 32) 0)
(check-expect (F-TO-C 50) 10)
(define (F-TO-C d)
  (* (- d 32) (/ 5 9)))

; List-of-numbers is one of
; - '()
; - (cons Number List-of-numbers)

; List-of-numbers -> List-of-numbers
(check-expect (convertFC '()) '())
(check-expect (convertFC (cons 32 '())) (cons 0 '()))
(check-expect (convertFC (cons 50 (cons 32 '()))) (cons 10 (cons 0 '())))
(define (convertFC f)
  (cond
    [(empty? f) '()]
    [else (cons (F-TO-C (first f))
                 (convertFC (rest f)))]))
