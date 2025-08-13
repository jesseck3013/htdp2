;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise489) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; Matrix -> Matrix 
; finds a row that doesn't start with 0 and
; uses it as the first one
; generative moves the first row to last place 
; no termination if all rows start with 0
(check-expect (rotate1 '((0 4 5) (1 2 3)))
              '((1 2 3) (0 4 5)))

(define (rotate1 M)  
  (cond
    [(andmap (lambda (row)
               (= (first row) 0)) M)
     (error "all rows start with 0")]
    [(not (= (first (first M)) 0)) M]
    [else
     (rotate1 (append (rest M) (list (first M))))]))

(check-error (rotate1 '((0 4 5) (0 2 3))))

; Matrix -> Matrix
(define (rotate/acc M0) 
  (local (
          ; acc is a list of rows that are removed from M
          ; rows are removed from M because they start with 0.
          (define (helper M acc)
            (local ((define first-row (first M)))
              (cond
                [(empty? M) (error "all rows start with 0")]
                [(= 0 (first first-row))
                 (helper (rest M) (cons first-row acc))]
                [else (append M acc)]))
            )
          )
    (helper M0 '())
    ))

(check-error (rotate/acc '((0 4 5) (0 2 3))))

(check-expect (rotate/acc '((0 4 5) (1 2 3)))
              '((1 2 3) (0 4 5)))

