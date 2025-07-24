;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise153) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; List-of-posns -> List-of-posns
; return a list of posns with x-coordinate in [0, 100], and y-coordinate in [0, 200].
(check-expect (legal '()) '())
(check-expect (legal (cons (make-posn 10 100) '()))
              (cons (make-posn 10 100) '()))
(check-expect (legal
               (cons (make-posn 20 50)
                     (cons (make-posn 10 100) '())))
               (cons (make-posn 20 50)
                     (cons (make-posn 10 100) '())))

(check-expect (legal (cons (make-posn 110 100) '()))
              '())
(check-expect (legal (cons (make-posn 10 300) '()))
              '())
(check-expect (legal (cons (make-posn 110 300) '()))
              '())

(define (legal lop)
  (cond
    [(empty? lop) '()]
    [else (if (legal-p (first lop))
              (cons (first lop) (legal (rest lop)))
              (legal (rest lop)))]))

; Posn -> Boolean
; return #true if p's x is in [0, 100], and y is in [0, 200]
(check-expect (legal-p (make-posn 19 19)) #true)
(check-expect (legal-p (make-posn 200 19)) #false)
(check-expect (legal-p (make-posn 19 399)) #false)
(check-expect (legal-p (make-posn 300 399)) #false)
(define (legal-p p)
  (and (>= (posn-x p) 0)
       (<= (posn-x p) 100)
       (>= (posn-y p) 0)
       (<= (posn-y p) 200)))
