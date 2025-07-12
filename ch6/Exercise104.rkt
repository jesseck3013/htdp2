 ;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise97) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; Vehicle is a structure:
; (make-vehicle type capacity license fuel)
; interpretation (make-vehicle t c l f) represents a vehicle, where
; - t is its type (one of automobile, van, bus, SUV)
; - c is its passenger capacity
; - l is its license number
; - f is its fuel consumption.
(define-struct vehicle [type capacity license fuel])

; Vehicle -> 
(define (f v)
  ...(vehicle-type v)...
  ...(vehicle-capacity v)...
  ...(vehicle-license v)...
  ...(vehicle-fuel v)...)
