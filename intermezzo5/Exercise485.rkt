;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise455) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; A number tree is one of:
; Number
; (list tree tree)

; number tree -> Number
(define (sum tree)
  (cond
    [(number? tree) tree]
    [else (+ (sum (first tree))
             (sum (second tree)))]))

(check-expect (sum (list (list 10 20)
                         (list 30 (list 20 20))))
              100)

; The order of n is 2^n, where n is the depth of the tree.

; Best case: tree is a number.

; Worst case: Every node is a pair of tree except for the deepest nodes.
