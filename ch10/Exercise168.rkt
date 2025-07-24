;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise153) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; List-of-posns -> List-of-posns
; move all posn's up y by 1 
(check-expect (translate '()) '())
(check-expect (translate (cons (make-posn 1 1) '()))
              (cons (make-posn 1 2) '()))
(check-expect (translate (cons (make-posn 10 1)
                               (cons (make-posn 1 1) '())))
              (cons (make-posn 10 2)
                    (cons (make-posn 1 2) '())))
(define (translate lop)
  (cond
    [(empty? lop) '()]
    [else (cons (move-up (first lop))
                (translate (rest lop)))]))

; Posn -> Posn
(check-expect (move-up (make-posn 10 10))
                  (make-posn 10 11))
(define (move-up p)
  (make-posn (posn-x p)
             (+ (posn-y p) 1)))

