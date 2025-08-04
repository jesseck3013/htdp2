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
(check-expect (depth 'world) 1)
(check-expect (depth '(world hello)) 2)
(check-expect (depth '(((world) hello) hello)) 4)

(define (depth sexp)
  (local (
          (define (depth-sl sl)
            (cond
              [(empty? sl) 0]
              [else
               (max 
                (depth (first sl))
                (depth-sl (rest sl)))]))
          )
 (cond
   [(atom? sexp) 1]
   [else (add1 (depth-sl sexp))])))

