;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname quote) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))

(define q1 '(1 "a" 2 #false 3 "c"))
(define l1 (list 1 "a" 2 #false 3 "c"))
(define c1 (cons 1
                 (cons "a"
                       (cons 2
                             (cons #false
                                   (cons 3
                                         (cons "c" '())))))))
(check-expect q1 l1)
(check-expect q1 c1)

(define q2 '())
(define l2 (list))
(check-expect q2 l2)

(define q3 '(("alan" 1000)
             ("barb" 2000)
             ("carl" 1500)))
(define l3 (list
            (list "alan" 1000)
            (list "barb" 2000)
            (list "carl" 1500)))
(define c3 (cons
            (cons "alan"
                  (cons 1000 '()))
            (cons 
             (cons "barb"
                   (cons 2000 '()))
             (cons 
              (cons "carl"
                    (cons 1500 '())) '()))))
(check-expect q3 l3)
(check-expect q3 c3)
