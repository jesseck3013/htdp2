;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise298) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; An S-expr is one of: 
; – Atom
; – SL

; An Atom is one of: 
; – Number
; – String
; – Symbol

; An SL is one of: 
; – '()
; – (cons S-expr SL)

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

; S-expr -> N 
; count the depth of an S-expr
(check-expect (substitute 'world 'world 'x) 'x)
(check-expect (substitute '(world hello) 'world 'x)
              '(x hello))
(check-expect (substitute '(((world) hello)) 'world 'x)
              '(((x) hello)))

(define (substitute sexp old new)
  (local (
          (define (substitute-atom sexp)
            (cond 
              [(number? sexp) sexp]
              [(string? sexp) sexp]
              [(symbol? sexp) (if (equal? sexp old)
                                  new
                                  sexp)]))
          
          (define (substitute-sl sexp)
            (cond
              [(empty? sexp) '()]
              [else (cons
                     (substitute (first sexp) old new)
                     (substitute-sl (rest sexp)))]))
          )
 (cond
   [(atom? sexp) (substitute-atom sexp)]
   [else (substitute-sl sexp)])))

