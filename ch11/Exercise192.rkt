;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |11|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define posn-1 (make-posn 1 1))
(define posn-2 (make-posn 2 2))
(define posn-3 (make-posn 3 3))
(define posn-4 (make-posn 4 4))

; NELoP -> Posn
; extracts the last item from p
(check-expect
 (last (list posn-1 posn-2 posn-3 posn-4)) posn-4)
(check-expect (last (list posn-1)) posn-1)
(define (last p)
  (cond
    [(empty? (rest p)) (first p)]
    [else (last (rest p))]))
