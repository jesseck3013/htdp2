;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise298) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; Any -> Boolean
; Output true if the type of expr is one of
; - number
; - string
; - symbol
(check-expect (atom? 1) #true)
(check-expect (atom? "hello") #true)
(check-expect (atom? 'xx) #true)
(check-expect (atom? (list 1 2 3)) #false)
(define (atom? expr)
  (cond
    [(number? expr) #true]
    [(string? expr) #true]
    [(symbol? expr) #true]
    [else #false]))

; S-expr Symbol Atom -> S-expr
; replaces all occurrences of old in sexp with new
 
(check-expect (substitute '(((world) bye) bye) 'bye '42)
              '(((world) 42) 42))
(check-expect (substitute 'world 'world 'x) 'x)
(check-expect (substitute '(world hello) 'world 'x)
              '(x hello))
(check-expect (substitute '(((world) hello)) 'world 'x)
              '(((x) hello)))
 
(define (substitute sexp old new)
  (local (; S-expr -> S-expr
          (define (for-sexp sexp)
            (cond
              [(atom? sexp) (for-atom sexp)]
              [else (for-sl sexp)]))
          ; SL -> S-expr 
          (define (for-sl sl)
            (map for-sexp sl))

          ; Atom -> S-expr
          (define (for-atom at)
            (if (equal? at old) new at)))
    (for-sexp sexp)))
