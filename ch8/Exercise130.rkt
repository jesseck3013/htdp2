;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise97) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(cons "1"
      (cons "2" '()))

; (cons "2" '())
; =
; (cons Sring List-of-names)
; =
; List-of-names

; (cons "1"
;      (cons "2" '()))
; =
; (cons "1"
;      List-of-names)
; = (cons String List-of-names)
; = List-of-names

; (cons 2 '()) is not List-of-names
; because 2 is not a string

