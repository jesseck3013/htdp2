;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |14.1|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; Function Nelon -> Number
(define (select func nl)
  (cond
    [(empty? (rest nl)) (first nl)]
    [else
     (cond
       [(func (first nl)
              (select func (rest nl)))
        (first nl)]
       [else (select func (rest nl))])]))

(define l1 (list 25 24 23 22 21 20 19 18 17 16 15 14 13
                 12 11 10 9 8 7 6 5 4 3 2 1))

(define l2 (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
      17 18 19 20 21 22 23 24 25))

;; (check-expect (inf-1 l1) 1)
;; (check-expect (inf-1 l2) 1)
(define (inf-1 l)
  (select < l))

;; (check-expect (sup-1 l1) 25)
;; (check-expect (sup-1 l2) 25)
(define (sup-1 l)
  (select > l))

; The above two functions are slow because (select func (rest nl)) might be called twice, once in comparison once in the second else branch.

; Nelon -> Number
; determines the smallest 
; number on l
(check-expect (inf-min l1) 1)
(check-expect (inf-min l2) 1)
(define (inf-min l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else
     (min (first l)
          (inf-min (rest l)))]))    

; Nelon -> Number
; determines the smallest 
; number on l
(check-expect (sup-max l1) 25)
(check-expect (sup-max l2) 25)
(define (sup-max l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else
     (max (first l)
          (sup-max (rest l)))]))
    
(define (select-1 func nel)
  (cond
    [(empty? (rest nel)) (first nel)]
    [else (func (first nel)
                (select-1 func (rest nel)))]))

; Nelon -> Number
; select the smallest number from a list
(check-expect (inf-2 l1) 1)
(check-expect (inf-2 l2) 1)
(define (inf-2 l)
  (select-1 min l))

; Nelon -> Number
; select the biggest number from a list
(check-expect (sup-2 l1) 25)
(check-expect (sup-2 l2) 25)
(define (sup-2 l)
  (select-1 max l))
