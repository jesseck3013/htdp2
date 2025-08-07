;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; A Pair is
; (cons Symbol (cons Number '()))

(define sl '(a b c))
(define nl '(1 2))
; [List-of Symbol] [List-of Number] -> [List-of Pair]
(check-expect (cross sl nl) '((a 1) (a 2) (b 1) (b 2) (c 1) (c 2)))

(define (cross los lon)
  (cond
    [(empty? los) '()]
    [else
     (append
      (make-pair (first los) lon)
      (cross (rest los) lon))]))

; Symbol [List-of Number] -> [List-of Pair]
(check-expect (make-pair 'a nl)
              '((a 1) (a 2)))
(define (make-pair s lon)
  (cond
    [(empty? lon) '()]
    [else
     (cons
      (list s (first lon))
      (make-pair s (rest lon)))]))
