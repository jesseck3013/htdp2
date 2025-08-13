;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise489) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; [List-of digits] -> Number
(define (to10 l0)
  (local (
          ; acc is the running total of all digits
          ; converted to 10 base number.
          (define (to10/acc l acc)
            (cond
              [(empty? l) acc]
              [else
               (local ((define current (* (first l)
                                          (expt 10
                                                (sub1 (length l))))))
                 (to10/acc (rest l) (+ acc current)))]))
            )
    (to10/acc l0 0)))

(check-expect (to10 '(1 0 2)) 102)
