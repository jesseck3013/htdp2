;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise153) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

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

(define CELL (rectangle 10 10 "outline" "black"))

(define GRID (col 18 (row 8 CELL)))

(define MT (empty-scene 80 180))
(define BG (place-image GRID (/ (image-width GRID) 2) (/ (image-height GRID) 2) MT))

(define BALLONS (circle 3 "solid" "red"))

; List-of-posn -> Image
; put ballons on the grid by ballons' position
(check-expect (add-ballons '()) BG)
(check-expect (add-ballons (cons (make-posn 10 10) '())) (place-image BALLONS 10 10 BG))
(check-expect (add-ballons (cons (make-posn 20 30) (cons (make-posn 10 10) '()))) (place-image BALLONS
                                                                                           20 30
                                                                                           (place-image BALLONS 10 10 BG)))
(define (add-ballons lop)
  (cond
    [(empty? lop) BG]
    [else (place-image
           BALLONS
           (posn-x (first lop))
           (posn-y (first lop))
           (add-ballons (rest lop)))]))

; List-of-posn -> List-of-posn
; all ballons drop 1 pixel per second
(check-expect (tock '()) '())
(check-expect (tock (cons (make-posn 10 10) '())) (cons (make-posn 10 11) '()))
(define (tock lob)
  (cond
    [(empty? lob) '()]
    [else (cons (make-posn (posn-x (first lob))
                           (+ (posn-y (first lob)) 1))
                (tock (rest lob)))]))

(define (riot lob)
  (big-bang lob
            [to-draw add-ballons]
            [on-tick tock 1]))

(riot (cons
       (make-posn 10 10)
       (cons (make-posn 20 20)
             (cons (make-posn 30 30) '()))))
