;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise153) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define-struct phone [area switch four])
; A Phone is a structure: 
;   (make-phone Three Three Four)
; A Three is a Number between 100 and 999. 
; A Four is a Number between 1000 and 9999. 

; List-of-phones -> List-of-phones
; replace all phones' whose area code is 713 with 281.
(check-expect (replace '()) '())
(check-expect (replace (cons (make-phone 713 123 456) '()))
              (cons (make-phone 281 123 456) '()))

(check-expect (replace (cons (make-phone 456 123 456)
                        (cons (make-phone 713 123 456) '())))
              (cons (make-phone 456 123 456)
                        (cons (make-phone 281 123 456) '())))

(define (replace phones)
  (cond
    [(empty? phones) '()]
    [else (cons (replace-area (first phones))
                (replace (rest phones)))]))

; Phone -> Phone
(check-expect (replace-area (make-phone 713 123 456))
              (make-phone 281 123 456))
(check-expect (replace-area (make-phone 456 123 456))
              (make-phone 456 123 456))
(define (replace-area p)
  (if (= (phone-area p) 713)
      (make-phone 281 (phone-switch p) (phone-four p))
      p))
