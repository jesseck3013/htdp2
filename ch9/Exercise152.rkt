;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise97) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define EXAMPLE-IMAGE (rectangle 20 20 "solid" "black"))
; Image -> Image 
; produce a column of n copies of img
(check-expect (col 0 EXAMPLE-IMAGE) empty-image)
(check-expect (col 1 EXAMPLE-IMAGE) (above EXAMPLE-IMAGE empty-image))
(check-expect (col 2 EXAMPLE-IMAGE) (above EXAMPLE-IMAGE (above EXAMPLE-IMAGE empty-image)))
(define (col n img)
  (cond
    [(zero? n) empty-image]
    [(positive? n) (above img (col (sub1 n) img))]))


; Image -> Image 
; produce a row of n copies of img
(check-expect (row 0 EXAMPLE-IMAGE) empty-image)
(check-expect (row 1 EXAMPLE-IMAGE) (beside EXAMPLE-IMAGE empty-image))
(check-expect (row 2 EXAMPLE-IMAGE) (beside EXAMPLE-IMAGE (beside EXAMPLE-IMAGE empty-image)))
(define (row n img)
  (cond
    [(zero? n) empty-image]
    [(positive? n) (beside img (row (sub1 n) img))]))
