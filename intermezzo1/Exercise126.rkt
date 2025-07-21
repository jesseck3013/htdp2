;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise97) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define-struct point [x y z])
(define-struct none  [])

(make-point 1 2 3) 
; (make-point 1 2 3)

(make-point (make-point 1 2 3) 4 5)
(make-point (make-point 1 2 3) 4 5)

(make-point (+ 1 2) 3 4) 
; (make-point 3 3 4)

(make-none)
; (make-none)

(make-point (point-x (make-point 1 2 3)) 4 5)
; (make-point 1 4 5)
