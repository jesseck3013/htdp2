;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise489) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; [X] [List-of X] -> N
(define (how-many l0)
  (local (
          ; acc is the number of items that have been removed
          ; from lox.
          (define (how-many/acc lox acc)
            (cond
              [(empty? lox) acc]
              [else (how-many/acc (rest lox)
                                  (add1 acc))]))
          )
    (how-many/acc l0 0)))

(check-expect (how-many '()) 0)
(check-expect (how-many '(1 2 3)) 3)

; The accumulator style is also O(n).

; Yes, it does reduce the space. Because every time there is a recursive call, acc can be evaluated immediately. The original implementation performs summation when it reachees '().
