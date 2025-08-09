;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define (my-expt x n)
  (cond
    [(= n 0) 1]
    [else (* x (my-expt x (sub1 n)))]))

(define inex (+ 1 #i1e-12))
(define exac (+ 1 1e-12))

(my-expt inex 30)
; #i1.0000000000300027

(my-expt exac 30)
;; 1.000000000030000000000435000000004060000000027405000000142506000000593775000002035800000005852925000014307150000030045015000054627300000086493225000119759850000145422675000155117520000145422675000119759850000086493225000054627300000030045015000014307150000005852925000002035800000000593775000000142506000000027405000000004060000000000435000000000030000000000001


; Which one is useful depends on your goal. If your goal is to get the computing as presice as possible, the second one is more useful. For normal cases, the first one is a good enough approximation.
