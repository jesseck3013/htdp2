;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname data_info) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; Two strategies produce the same Manhattan distance.

; Posn -> Number
(check-expect (manhattan-distance (make-posn 3 4)) 7)
(check-expect (manhattan-distance (make-posn 0 0)) 0)
(check-expect (manhattan-distance (make-posn 3 0)) 3)
(check-expect (manhattan-distance (make-posn 0 4)) 4)
(define (manhattan-distance p)
  (+ (posn-x p) (posn-y p)))
