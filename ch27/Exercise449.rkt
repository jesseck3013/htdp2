;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |27.1|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define ε 0.01)

; Number -> Number
(define (poly x)
  (* (- x 2) (- x 4)))

; [Number -> Number] Number Number -> Number
; determines R such that f has a root in [R,(+ R ε)]
; assume f is continuous 
; assume (or (<= (f left) 0 (f right)) (<= (f right) 0 (f left)))
; generative divides interval in half, the root is in one of the two
; halves, picks according to assumption 
(define (find-root f left right)
  (cond
    [(<= (- right left) ε) left]
    [else
      (local ((define mid (/ (+ left right) 2))
              (define f@mid (f mid))
              (define f-left (f left))
              (define f-right (f right)))
        (cond
          [(or (<= f-left 0 f@mid) (<= f@mid 0 f-left))
           (find-root f left mid)]
          [(or (<= f@mid 0 f-right) (<= f-right 0 f@mid))
           (find-root f mid right)]))]))

(check-within (find-root poly 0 3)
              2
              0.01)
(check-within (find-root poly 3 5)
              4
              0.01)

; This optimization saves 1 (f left) call.

; [Number -> Number] Number Number -> Number
(define (find-root-acc f left right)
  (local (
          (define (helper left f-left right f-right)
            (if (<= (- right left) ε)
                left
                (local (
                        (define mid (/ (+ left right) 2))
                        (define f@mid (f mid))                       
                        )
                  (cond
                    [(or (<= f-left 0 f@mid) (<= f@mid 0 f-left))
                     (helper left f-left mid f@mid)]
                    [(or (<= f@mid 0 f-right) (<= f-right 0 f@mid))
                     (helper mid f@mid right f-right)]))))
          )
    (helper left (f left) right (f right))))

(check-within (find-root-acc poly 0 3)
              2
              0.01)
(check-within (find-root-acc poly 3 5)
              4
              0.01)

; If left changes in every recursive call, it saves 1 calls compared to the original implementation.
; It saves 1 call in the (or (<= (f left) 0 f@mid) (<= f@mid 0 (f left)))

; If left serves as the boundry 2 times, it saves 3 (f left) calls.
; 1 in the (or (<= (f left) 0 f@mid) (<= f@mid 0 (f left))), 2 in the following recursive call.

; If left is always the boundry, there is only one (f left) call.

