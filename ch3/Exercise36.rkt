;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname data_info) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; Image -> Number
; compute the area of an image
; given (rectangle 10 20 "solid" "red"), expect 200
; given (rectangle 10 10 "solid" "red"), expect 100
(define (image-area img)
  (* (image-width img)
     (image-height img)))

(image-area (rectangle 10 20 "solid" "red"))
(image-area (rectangle 10 10 "solid" "red"))
