;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise455) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define UNIT 100)

(define (double-amount interest-rate)
  (local (
          (define (count-month saving)
            (cond
              [(>= (/ saving UNIT) 2) 0]
              [else (add1 (count-month
                           (*
                            (+ 1 interest-rate)
                            saving)))]))
          )
    (count-month UNIT)))

(check-expect (double-amount 0.01) 70)
(check-expect (double-amount 0.04) 18)


