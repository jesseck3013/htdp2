;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise97) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; List-of-amounts -> Number
(check-expect (sum '()) 0)
(check-expect (sum (cons 1 '())) 1)
(check-expect (sum (cons 2 (cons 1 '()))) 3)

(define (sum loa)
  (cond
    [(empty? loa) 0]
    [else
     (+ (first loa)
        (sum 
         (rest loa)))]))

; A List-of-numbers is one of: 
; – '()
; – (cons Number List-of-numbers)

; List-of-numbers -> Boolean
(check-expect (pos? '()) #true)
(check-expect (pos? (cons 1 '())) #true)
(check-expect (pos? (cons 2 (cons 1 '()))) #true)
(check-expect (pos? (cons -1 '())) #false)
(check-expect (pos? (cons 2 (cons -1 '()))) #false)
(define (pos? l)
  (cond
    [(empty? l) #true]
    [else
     (if (> (first l) 0)
         (pos? (rest l))
         #false)]))

;; List-of-numbers -> Number
(check-error (checked-sum (cons -1 '())))
(check-expect (checked-sum (cons 1 '())) 1)
(check-expect (checked-sum (cons 2 (cons 1 '()))) 3)
(define (checked-sum l)
  (cond
    [(pos? l) (sum l)]
    [else (error "l is not List-of-ammounts")]))
