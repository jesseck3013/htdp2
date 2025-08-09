;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |25.1|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define MAX 1)

; When MAX is 1, (random MAX) is always the same. The function always creates (make-posn 1 1). Suppose the input is (make-posn 1 1), the function is stuck in an infinite loop.

; Posn -> Posn 
; ???
(check-error (food-create (make-posn 1 1)))
(check-satisfied (food-create (make-posn 1 1)) not=-1-1?)
(define (food-create p)
  (local (
          ; Posn Posn -> Posn 
          ; generative recursion 
          ; ???
          (define (food-check-create p candidate)
            (if
             (equal? p candidate)
             (food-create p)
             candidate))
          )
    (if (and (= MAX 1) (equal? p (make-posn 1 1)))
        (error "MAX cannot be 1")
        (food-check-create
         p (make-posn (random MAX) (random MAX))))))

; Posn -> Boolean
; use for testing only 
(define (not=-1-1? p)
  (not (and (= (posn-x p) 1) (= (posn-y p) 1))))

