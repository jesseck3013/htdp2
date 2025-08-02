;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise265) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; [X] [List-of X] [List-of X] -> [List-of X]
(check-expect
 (append-from-fold (list 1 2 3) (list 4 5 6 7 8))
 (append (list 1 2 3) (list 4 5 6 7 8)))

(define (append-from-fold l1 l2)
  (foldr cons l2 l1))

; With foldl, the order of l1 part's is reverse.

; [List-of Number] -> Number
(check-expect (sum-from-fold (list 1 2 3 4))
              10)
(define (sum-from-fold lon)
  (foldr + 0 lon))

; [List-of Number] -> Number
(check-expect (product-from-fold (list 1 2 3 4))
              24)
(define (product-from-fold lon)
  (foldr * 1 lon))

; [List-of image] -> Image
(check-expect (compose-horizontally
               (list
                (rectangle 10 10 "solid" "black")
                (rectangle 20 20 "solid" "black")
                (rectangle 30 30 "solid" "black")))
              (beside
               (rectangle 10 10 "solid" "black")
               (beside
                (rectangle 20 20 "solid" "black")
                (beside
                 (rectangle 30 30 "solid" "black")
                 empty-image))))
(define (compose-horizontally loi)
  (foldr beside empty-image loi))


; [List-of image] -> Image
(check-expect (compose-vertically
               (list
                (rectangle 10 10 "solid" "black")
                (rectangle 20 20 "solid" "black")
                (rectangle 30 30 "solid" "black")))
              (above
               (rectangle 10 10 "solid" "black")
               (above
                (rectangle 20 20 "solid" "black")
                (above
                 (rectangle 30 30 "solid" "black")
                 empty-image))))
(define (compose-vertically loi)
  (foldr above empty-image loi))
