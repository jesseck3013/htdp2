;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise489) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; [List-of X] -> [List-of X]
; constructs the reverse of alox
 
(check-expect (invert '(a b c)) '(c b a))
 
(define (invert alox)
  (cond
    [(empty? alox) '()]
    [else
     (add-as-last (first alox) (invert (rest alox)))]))
 
; X [List-of X] -> [List-of X]
; adds an-x to the end of alox
 
(check-expect (add-as-last 'a '(c b)) '(c b a))
 
(define (add-as-last an-x alox)
  (cond
    [(empty? alox) (list an-x)]
    [else
     (cons (first alox) (add-as-last an-x (rest alox)))]))

;; (invert '(a b c))
;; == (add-as-last 'a (invert '(b c)))
;; == (add-as-last 'a (add-as-last 'b (invert '(c))))
;; == (add-as-last 'a (add-as-last 'b 'c (invert '())))
;; == (add-as-last 'a (add-as-last 'b '(c)))
;; == (add-as-last 'a '(c b))
;; == '(c b a)

;input size 0
;invert     0 * add-as-last

;input size 1
;invert     1 * (add-as-last with 0 input size)

;input size 2
;invert     2 * (add-as-last with 1 input size)

;input size 3
;invert     3 * (add-as-last with 2 input size)

; ...

;input size n - 1
;invert     (n - 1) * (add-as-last with (n - 2) input size)

;input size n
;invert     n * (add-as-last with (n - 1) input size)


; add-as-last has O(n), because it always go through all the elements of the input list.
; when invert is given an input with size n, it triggers n add-as-last calls. Each add-as-last call has input size from n-1, n -2, ... to 1 0.
; That means the run time is n - 1 + n - 2 + ... + 1 + 0 which is O(n^2).
