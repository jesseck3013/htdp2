;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise97) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; NEList-of-temperatures -> Boolean
; output #true when numbers in ne-l are in a descending order
(check-expect (sorted>? (cons 1 '())) #true)
(check-expect (sorted>? (cons 2 (cons 1 '()))) #true)
(check-expect (sorted>? (cons 1 (cons 2 '()))) #false)
(define (sorted>? ne-l)
  (cond
    [(empty? (rest ne-l)) #true]
    [else (if (> (first ne-l)
                 (first (rest ne-l)))
              (sorted>? (rest ne-l))
              #false)]))
