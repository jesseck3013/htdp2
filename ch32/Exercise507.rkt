;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise489) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; [X Y] [X Y -> Y] Y [List-of X] -> Y
(define (f*ldl f i l0)
  (local (
          ; [X Y] [List-of Y] [List-of X]
          (define (foldr/a a l)
            (cond
              [(empty? l) a]
              [else
               (foldr/a (f (first l) a) (rest l))])))
    (foldr/a i l0)))

; [X] N [N -> X] -> [List-of X]
(define (build-l*st n0 f)
  (local (
          (define (build-l*st/acc n acc)
            (cond
              [(= n -1) acc]
              [else
               (build-l*st/acc (sub1 n)
                               (cons (f n)
                                     acc))]))
          )
    (build-l*st/acc (sub1 n0) '())
    ))

(define F (lambda (x) x))
(check-expect (build-l*st 100 F) (build-list 100 F))


