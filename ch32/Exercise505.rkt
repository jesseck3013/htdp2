;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise489) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; N -> Boolean
(define (is-prime n0)
  (local (
          (define (helper n)
            (cond
              [(= n 1) #true]
              [(= (remainder n0 n) 0) #false]
              [else (helper (sub1 n))]))
          )
    (if (<= n0 1)
        #false
        (helper (sub1 n0)))))

(check-expect (is-prime 1) #false)
(check-expect (is-prime 3) #true)
(check-expect (is-prime 4) #false)
