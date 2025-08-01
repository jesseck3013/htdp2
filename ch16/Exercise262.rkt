;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |14.1|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; a Matrix is a [List-of [List-of Number]]

; Number -> Matrix
(check-expect (identityM 1)
              (list (list 1)))

(check-expect (identityM 3)
              (list (list 1 0 0) (list 0 1 0) (list 0 0 1)))

(define (identityM n)
  (local
      (
       ; Number Number -> [List-of Number]
       (define (new-row len pos)
         (cond
           [(= len 0) '()]
           [(= len pos)
            (cons 1
                  (new-row (sub1 len) pos))]
           [else (cons 0
                       (new-row (sub1 len) pos))]))
       
       ; Number Number -> Matrix
       (define (new-matrix row-count one-pos)
         (cond
           [(= row-count 0) '()]
           [else
            (cons
             (new-row n one-pos)
             (new-matrix (sub1 row-count) (sub1 one-pos)))])))
    (new-matrix n n)))
      
    
(define (new-row len pos)
  (cond
    [(= len 0) '()]
    [(= len pos)
     (cons 1
           (new-row (sub1 len) pos))]
    [else (cons 0
                (new-row (sub1 len) pos))]))

