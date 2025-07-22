;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise97) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; List-of-images -> ImageOrFalse
; produce the first image whose size is not n * n.
(define N-By-N (rectangle 10 10 "solid" "black"))
(define N-By-M (rectangle 10 20 "solid" "black"))
(check-expect (ill-sized? '()) #false)
(check-expect (ill-sized? (cons N-By-N '())) #false)
(check-expect (ill-sized? (cons N-By-M '())) N-By-M)

(define (ill-sized? loi)
  (cond
    [(empty? loi) #false]
    [else
     (if (= (image-width (first loi))
            (image-height (first loi)))
         (ill-sized? (rest loi))
         (first loi))]))
