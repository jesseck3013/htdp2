;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |11|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; Number List-of-numbers -> Boolean
(define (search n alon)
  (cond
    [(empty? alon) #false]
    [else (or (= (first alon) n)
              (search n (rest alon)))]))


; Number List-of-numbers -> Boolean
(check-expect (search-sorted 10 '()) #false)
(check-expect (search-sorted 1 (list 4 3 2 1)) #true)
(check-expect (search-sorted 10 (list 4 3 2 1)) #false)
(define (search-sorted n alon)
  (cond
    [(empty? alon) #false]
    [(> n (first alon)) #false]
    [else (or (= (first alon) n)
              (search n (rest alon)))]))

