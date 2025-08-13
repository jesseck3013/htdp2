;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise489) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; [X Y] [X -> Y] [List-of X] -> [List-of Y]
(define (map1 f l)
  (cond
    [(empty? l) '()]
    [else (cons (f (first l))
                (map1 f (rest l)))]))

(define (map2 f l0)
  (local (
          ; acc is the list of numbers from l.
          ; numbers in acc are mapped using function f.
          (define (map/acc l acc)
            (cond
              [(empty? l) acc]
              [else (map/acc (rest l)
                             (cons (f (first l))
                                   acc))]))
          )
    (map/acc (reverse l0) '())))


(check-expect (map2 (lambda (x) x) (list 1 2 3))
              (list 1 2 3))
