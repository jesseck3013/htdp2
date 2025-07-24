;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise153) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; List-of-string String -> N
; determines how often s occurs in los
(check-expect (count '() "x") 0)
(check-expect (count (cons "x" '()) "x") 1)
(check-expect (count (cons "x" (cons "x" '())) "x") 2)
(check-expect (count (cons "y" '()) "x") 0)
(define (count los s)
  (cond
    [(empty? los) 0]
    [else
     (if (string=? (first los) s)
         (+ 1 (count (rest los) s))
         (count (rest los) s))]))

; Son
(define es '())

; Number Son -> Boolean
; is x in s
(define (in? x s)
  (member? x s))

; Number Son.L -> Son.L
; removes x from s 
(define s1.L
  (cons 1 (cons 1 '())))
 
(check-expect
  (set-.L 1 s1.L) es)
 
(define (set-.L x s)
  (remove-all x s))

; Number Son.R -> Son.R
; removes x from s
(define s1.R
  (cons 1 '()))
 
(check-expect
  (set-.R 1 s1.R) es)
 
(define (set-.R x s)
  (remove x s))

(define set123-version1
  (cons 1 (cons 2 (cons 3 '()))))
 
(define set123-version2
  (cons 1 (cons 3 (cons 2 '()))))

(define set23-version1
  (cons 2 (cons 3 '())))
 
(define set23-version2
  (cons 3 (cons 2 '())))

(check-member-of (set-.L 1 set123-version1)
                 set23-version1
                 set23-version2)

(check-member-of (set-.R 1 set123-version1)
                 set23-version1
                 set23-version2)

; Son -> Boolean
; #true if 1 is not a member of s;  #false otherwise
(define (not-member-1? s)
  (not (in? 1 s)))

(check-satisfied (set-.L 1 set123-version1) not-member-1?)


; Number Son.L -> Son.L
; add x in s  
(check-expect
 (set+.L 1 s1.L) (cons 1 s1.L))
(check-expect
  (set+.L 2 s1.L) (cons 2 s1.L))
 
(define (set+.L x s)
  (cons x s))

; Number Son.R -> Son.R
; add x in s
(check-expect
 (set+.R 1 s1.R) s1.R)
(check-expect
 (set+.R 2 s1.R) (cons 2 s1.R))
 
(define (set+.R x s)
  (if (in? x s)
      s
      (cons x s)))
