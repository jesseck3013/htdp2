;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |14.1|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; Function Nelon -> Number
(define (select func nl)
  (cond
    [(empty? (rest nl)) (first nl)]
    [else
     (local
         ((define select-func-on-rest
            (select func (rest nl))))
       (cond
         [(func (first nl)
                select-func-on-rest)
          (first nl)]
         [else select-func-on-rest]))]))

(define l1 (list 25 24 23 22 21 20 19 18 17 16 15 14 13
                 12 11 10 9 8 7 6 5 4 3 2 1))

(define l2 (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
      17 18 19 20 21 22 23 24 25))

(check-expect (inf-1 l1) 1)
(check-expect (inf-1 l2) 1)
(define (inf-1 l)
  (select < l))

(check-expect (sup-1 l1) 25)
(check-expect (sup-1 l2) 25)
(define (sup-1 l)
  (select > l))    
