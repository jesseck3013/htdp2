;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise153) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; List-of-numbers -> List-of-numbers
; computes the weekly wages for all given weekly hours
(define (wage* whrs)
  (cond
    [(empty? whrs) '()]
    [else (cons (wage (first whrs)) (wage* (rest whrs)))]))
 
; Number -> Number
; computes the wage for h hours of work
(define (wage h)
  (* 12 h))

(define-struct work [employee rate hours])
; A (piece of) Work is a structure: 
;   (make-work String Number Number)
; interpretation (make-work n r h) combines the name 
; with the pay rate r and the number of hours h

; Low (short for list of works) is one of: 
; – '()
; – (cons Work Low)
; interpretation an instance of Low represents the 
; hours worked for a number of employees

; Low -> List-of-numbers
; computes the weekly wages for all weekly work records 

(check-expect
 (wage*.v2 (cons (make-work "Robby" 11.95 39) '()))
 (cons (* 11.95 39) '()))

(define (wage*.v2 an-low)
  (cond
    [(empty? an-low) '()]
    [(cons? an-low) (cons (wage.v2 (first an-low))
                          (wage*.v2 (rest an-low)))]))

; Work -> Number
; computes the wage for the given work record w
(define (wage.v2 w)
  (* (work-rate w) (work-hours w)))


(define-struct paycheck [name wage])

; Low -> List-of-numbers
; computes the weekly wages for all weekly work records 

(check-expect
 (wage*.v3 (cons (make-work "Robby" 11.95 39) '()))
 (cons (make-paycheck "Robby" (* 11.95 39)) '()))

(define (wage*.v3 an-low)
  (cond
    [(empty? an-low) '()]
    [(cons? an-low) (cons (wage.v3 (first an-low))
                          (wage*.v3 (rest an-low)))]))

; Work -> Number
; computes the wage for the given work record w
(define (wage.v3 w)
  (make-paycheck
   (work-employee w)
   (* (work-rate w) (work-hours w))))

(define-struct work.v2 [employee number rate hours])
(define-struct paycheck.v2 [name number wage])

; Low -> List-of-numbers
; computes the weekly wages for all weekly work records 
(check-expect
 (wage*.v4 (cons (make-work.v2 "Robby" 001 11.95 39) '()))
 (cons (make-paycheck.v2 "Robby" 001 (* 11.95 39)) '()))

(define (wage*.v4 an-low)
  (cond
    [(empty? an-low) '()]
    [(cons? an-low) (cons (wage.v4 (first an-low))
                          (wage*.v4 (rest an-low)))]))

; Work -> Number
; computes the wage for the given work record w
(define (wage.v4 w)
  (make-paycheck.v2
   (work.v2-employee w)
   (work.v2-number w)
   (* (work.v2-rate w) (work.v2-hours w))))
