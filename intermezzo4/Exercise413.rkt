;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; N Number N -> Inex
; makes an instance of Inex after checking the arguments
(define (create-inex m s e)
  (cond
    [(and (<= 0 m 99) (<= 0 e 99) (or (= s 1) (= s -1)))
     (make-inex m s e)]
    [else (error "bad values given")]))
 
; Inex -> Number
; converts an inex into its numeric equivalent 
(define (inex->number an-inex)
  (* (inex-mantissa an-inex)
     (expt
      10 (* (inex-sign an-inex) (inex-exponent an-inex)))))

(define-struct inex [mantissa sign exponent])
; An Inex is a structure: 
;   (make-inex N99 S N99)
; An S is one of:
; – 1
; – -1
; An N99 is an N between 0 and 99 (inclusive).

(define MAX-POSITIVE (create-inex 99 1 99))
(define MIN-POSITIVE (create-inex 1 -1 99))

; Inex Inex -> Inex
(define (inex* inex1 inex2)
  (local (
          ;(inex+ (create-inex 1 1 0) (create-inex 1 -1 1))
          (define ex1
            (* (inex-sign inex1)
               (inex-exponent inex1)))

          (define ex2
            (* (inex-sign inex2)
               (inex-exponent inex2)))

          (define ex (+ ex1 ex2))

          (define m
            (* (inex-mantissa inex1)
               (inex-mantissa inex2)))          

          (define (convert m ex)
            (cond
              [(> m 99) (convert (/ m 10)
                                 (add1 ex))]
              [else (list m ex)])
            )

          (define m-and-ex (convert m ex))
          (define m-converted (round (first m-and-ex)))
          (define ex-converted (second m-and-ex))
          (define s-converted (if (>= ex-converted 0)
                                  1
                                  -1))
          )
    (cond
      [(> (abs ex-converted) 99) (error "overflow")]
      [else (make-inex m-converted
                       s-converted
                       (abs ex-converted))])))

(check-expect
 (inex* (create-inex 2 1 4) (create-inex 8 1 10))
 (create-inex 16 1 14))

(check-expect
 (inex* (create-inex 20 1 1) (create-inex  5 1 4)) 
 (create-inex 10 1 6))

(check-expect
 (inex* (create-inex 27 -1 1) (create-inex  7 1 4))
 (create-inex 19 1 4))

(check-error
 (inex+ (create-inex 1 1 98) (create-inex 1 1 2)))

; Number -> Boolean
(check-expect (natural? 10) #true)
(check-expect (natural? (/ 11 10)) #false)
(define (natural? x)
  (cond
    [(< x 0) #false]
    [(= x 0) #true]
    [else (natural? (sub1 x))]))
