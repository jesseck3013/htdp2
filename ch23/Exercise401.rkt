;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; An S-expr (S-expression) is one of: 
; – Atom
; – [List-of S-expr]
; 
; An Atom is one of: 
; – Number
; – String
; – Symbol

; Any -> Boolean
(check-expect (atom? 1) #true)
(check-expect (atom? "s") #true)
(check-expect (atom? 's) #true)
(check-expect (atom? '()) #false)
(define (atom? s)
  (or (number? s)
      (string? s)
      (symbol? s)))

; Atom Atom -> Boolean
(check-expect (atom=? 1 1) #true)
(check-expect (atom=? "a" "a") #true)
(check-expect (atom=? 'a 'a) #true)

(check-expect (atom=? 1 'a) #false)
(check-expect (atom=? 1 "a") #false)

(define (atom=? a1 a2)
  (cond
    [(and (number? a1) (number? a2)) (= a1 a2)]
    [(and (string? a1) (string? a2)) (string=? a1 a2)]
    [(and (symbol? a1) (symbol? a2)) (symbol=? a1 a2)]
    [else #false]))

;             s1       Atom  [List-of S-expr]
;       s2
;      Atom            equal?     #false
; [List-of S-expr]     #false     recursive call 

; S-expression S-expression -> Boolean
(check-expect (sexp=? 1 1) #true)
(check-expect (sexp=? "s" "s") #true)
(check-expect (sexp=? 's 's) #true)
(check-expect (sexp=? '() '()) #true)

(check-expect (sexp=? '(a (b (c) (d e f)))
                      (list 'a (list 'b (list 'c) (list 'd 'e 'f))))
              #true)

(define (sexp=? s1 s2)
  (cond
    [(and (atom? s1) (atom? s2))
     (atom=? s1 s2)]
    [(and (atom? s1) (not (atom? s2))) #false]
    [(and (not (atom? s1)) (atom? s2)) #false]
    [(and (empty? s1) (empty? s2)) #true]
    [(and (not (atom? s1)) (not (atom? s2)))
     (and (sexp=? (first s1) (first s2))
          (sexp=? (rest s1) (rest s2)))]))
