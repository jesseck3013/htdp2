;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise265) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; Number -> [List-of Number]
(check-expect (build-list-1 10)
              (list 0 1 2 3 4 5 6 7 8 9))
(define (build-list-1 n)
  (local (
          (define (self x) x)
          )
    (build-list n self)))

; Number -> [List-of Number]
(check-expect (build-list-2 10)
              (list 1 2 3 4 5 6 7 8 9 10))
(define (build-list-2 n)
    (build-list n add1))

; Number -> [List-of Number]
(check-expect (build-list-3 10)
              (list 1 1/2 1/3 1/4 1/5 1/6 1/7 1/8 1/9 1/10))
(define (build-list-3 n)
  (local (
          (define (f x)
            (/ 1 (add1 x)))
          )
    (build-list n f)))

; Number -> [List-of Number]
(check-expect (build-list-4 10)
              (list 0 2 4 6 8 10 12 14 16 18))
(define (build-list-4 n)
  (local ((define (to-even x)
            (* x 2)))
    (build-list n to-even)))

; Number -> [List-of [List-of Number]]
(check-expect (build-list-5 1)
              (list (list 1)))
(check-expect (build-list-5 3)
              (list (list 1 0 0) (list 0 1 0) (list 0 0 1)))
(define (build-list-5 n)
  (local (
          ; Number Number -> [List-of Number]
          (define (new-row len pos)
            (local (
                    (define (isOne item)
                      (if (= item pos)
                          1
                          0)
                      )
                    )
            (build-list len isOne)))
          ; Number -> [List-of [List-of Number]]
          (define (build-row item)
            (new-row n item)))
    (build-list n build-row)))

; [Number -> Number] Number -> [List-of Number]
(check-within
 (build-list-6 sin 3)
 (list (sin 3) (sin 2) (sin 1) (sin 0))
 0.01)
(define (build-list-6 func n)
  (reverse (build-list (add1 n) func)))



