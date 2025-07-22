;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise97) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; String List-of-strings -> Boolean
; Output #true when the target String is in the list
(check-expect (contains? "Flatt" (cons "b" (cons "Flatt" '()))) #true)
(check-expect (contains? "Flatt" (cons "b" (cons "hhh" '()))) #false)
(check-expect (contains? "Flatt" '()) #false)
(define (contains? s l)
  (cond
    [(empty? l) #false]
    [else
     (if (string=? (first l) s)
         #true
         (contains? s (rest l)))]))
