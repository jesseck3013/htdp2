;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise451) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define-struct table [length array])
; A Table is a structure:
;   (make-table N [N -> Number])

; Table N -> Number
; looks up the ith value in array of t
(define (table-ref t i)
  ((table-array t) i))

; Number Number -> Number
(check-expect (closer-to-0 (lambda (x) x) 1 2) 1)
(check-expect (closer-to-0 (lambda (x) x) -1 2) -1)
(define (closer-to-0 f x1 x2)
  (if (< (abs (f x1)) (abs (f x2)))
      x1
      x2))

(define (find-linear t)
  (local (
          (define len (table-length t))

          (define (helper i)
            (cond
              [(= i (sub1 len))
               (if (> (table-ref t i) 0)
                   0
                   i)]
              [(<= (table-ref t i)
                   0
                   (table-ref t (add1 i)))
               (closer-to-0
                (table-array t)
                i
                (add1 i))]
              [else (helper (add1 i))]))
          )
    (helper 0)))

(define table1 (make-table 10 (lambda (x) x)))
(define table2 (make-table 20 (lambda (x) (- x 10))))
(define table3 (make-table 20 (lambda (x) (+ x 10))))
(check-expect (find-linear table1) 0)
(check-expect (find-linear table2) 10)
(check-expect (find-linear table3) 0)


(define (find-binary t)
  (local (
          (define len (table-length t))

          (define (helper left right)
            (local (
                    ; this should be natural number
                    (define mid (round
                                 (/ (+ left right) 2)))
                    (define arr (table-array t))
                    )
              (cond
                [(<= (- right left) 1)
                 (closer-to-0 (table-array t)
                             left
                             right)]
                [else
                 (helper
                  (closer-to-0 arr left mid)
                  (closer-to-0 arr mid right))])
                ))
          )
    (helper 0 (sub1 len))))

(check-expect (find-binary table1) 0)
(check-expect (find-binary table2) 10)
(check-expect (find-binary table3) 0)

(define table4 (make-table 1024 (lambda (x) (- x 1023))))
(check-expect (find-binary table4) 1023)

; find-binary will terminate because the distance between left and right is becoming closer for every recursive calls.
