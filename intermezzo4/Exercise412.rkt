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
(define (inex+ inex1 inex2)
  (local (
          ;(inex+ (create-inex 1 1 0) (create-inex 1 -1 1))
          (define ex1
            (* (inex-sign inex1)
               (inex-exponent inex1)))

          (define ex2
            (* (inex-sign inex2)
               (inex-exponent inex2)))
          ; 0 -1
          (define ex-temp
            (cond
              [(> ex1 ex2) ex1]
              [else ex2]))

;          ex:0  m: 1 + 11/10
          (define m-temp
            (cond
              [(> ex1 ex2)
               (+ (inex-mantissa inex1)
                  (/ (inex-mantissa inex2) 10))]
              [(< ex1 ex2)
               (+ (/ (inex-mantissa inex1) 10)
                  (inex-mantissa inex2))]
              [else
               (+ (inex-mantissa inex1)
                  (inex-mantissa inex2))]))

          (define m
            (if (natural? m-temp)
                m-temp
                (* m-temp 10)))

          (define ex
            (if (natural? m-temp)
                ex-temp
                (sub1 ex-temp)))

          ; (list n n) -> (list n n)
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
 (inex+ (create-inex 56 1 0) (create-inex 56 1 0))
 (create-inex 11 1 1))

(check-expect
 (inex+ (create-inex 55 1 0) (create-inex 55 1 0))
 (create-inex 11 1 1))

(check-error
 (inex+ (create-inex 55 1 99) (create-inex 55 1 99)))

(check-expect
 (inex+ (create-inex 0 1 0) (create-inex 0 1 0))
 (create-inex 0 1 0))

(check-expect
 (inex+ (create-inex 1 1 0) (create-inex 1 -1 1))
 (create-inex 11 -1 1))

; Number -> Boolean
(check-expect (natural? 10) #true)
(check-expect (natural? (/ 11 10)) #false)
(define (natural? x)
  (cond
    [(< x 0) #false]
    [(= x 0) #true]
    [else (natural? (sub1 x))]))
