;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname data_info) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; time is a structure:
; (make-time Number Number Number)
(define-struct time [hours minutes seconds])

; time -> Number
; convert time to the number of seconds that have passed since midnight
(check-expect (time->seconds (make-time 0 0 0)) 0)
(check-expect (time->seconds (make-time 0 0 5)) 5)
(check-expect (time->seconds (make-time 0 1 5)) 65)
(check-expect (time->seconds (make-time 12 30 2)) 45002)
(define (time->seconds t)
  (+ (* 60 (* 60 (time-hours t))) 
     (* 60 (time-minutes t)) 
     (time-seconds t)))
