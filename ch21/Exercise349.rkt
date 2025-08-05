;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise349) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define WRONG "Error: Syntax Incorrect")

(define-struct add [left right])
(define-struct mul [left right])

; Any -> Boolean
(check-expect (atom? 1) #true)
(check-expect (atom? "xx") #true)
(check-expect (atom? 's) #true)
(check-expect (atom? '()) #false)

(define (atom? expr)
  (or (number? expr) 
  (string? expr)
  (symbol? expr)))

; S-expr -> BSL-expr
(check-expect (parse 10) 10)
(check-expect (parse '(+ 1 1)) (make-add 1 1))

(define (parse s)
  (cond
    [(atom? s) (parse-atom s)]
    [else (parse-sl s)]))
 
; SL -> BSL-expr
(check-error (parse-sl '(+ 1)))
(check-expect (parse-sl '(+ 1 1)) (make-add 1 1))
(check-expect (parse-sl '(* 1 1)) (make-mul 1 1))
(check-error (parse-sl '(- 1 1)))
(check-error (parse-sl '(+ 1 1 1)))

(define (parse-sl s)
  (local ((define L (length s)))
    (cond
      [(< L 3) (error WRONG)]
      [(and (= L 3) (symbol? (first s)))
       (cond
         [(symbol=? (first s) '+)
          (make-add (parse (second s)) (parse (third s)))]
         [(symbol=? (first s) '*)
          (make-mul (parse (second s)) (parse (third s)))]
         [else (error WRONG)])]
      [else (error WRONG)])))
 
; Atom -> BSL-expr
(check-expect (parse-atom 10) 10)
(check-error (parse-atom "xx"))
(check-error (parse-atom 'x))

(define (parse-atom s)
  (cond
    [(number? s) s]
    [(string? s) (error WRONG)]
    [(symbol? s) (error WRONG)]))