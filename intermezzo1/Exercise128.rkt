;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise97) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(check-member-of "green" "red" "yellow" "grey")
; not pass, because green is not equal to "red", "yellow" , "grey"

(check-within (make-posn #i1.0 #i1.1)
              (make-posn #i0.9 #i1.2)  0.01)
; not pass
; because these two posns are not within 0.01

(check-range #i0.9 #i0.6 #i0.8)
; not pass
; #i0.9 is out of the interval between #i0.6 #i0.8

(check-random (make-posn (random 3) (random 9))
              (make-posn (random 9) (random 3)))
; sometimes pass somethimes not pass

(check-satisfied 4 odd?)
; not pass because 4 is an even number

