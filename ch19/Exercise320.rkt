;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise298) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; An S-expr is one of: 
; – Number
; – String
; – Symbol
; – [List-of S-expr]

;; (check-expect (atom? 1) #true)
;; (check-expect (atom? "hello") #true)
;; (check-expect (atom? 'xx) #true)
;; (check-expect (atom? (list 1 2 3)) #false)
;; (define (atom? expr)
;;   (cond
;;     [(number? expr) #true]
;;     [(string? expr) #true]
;;     [(symbol? expr) #true]
;;     [else #false]))

; S-expr Symbol -> N 
; counts all occurrences of sy in sexp 
(check-expect (count 'world 'hello) 0)
(check-expect (count '(world hello) 'hello) 1)
(check-expect (count '(((world) hello) hello) 'hello) 2)

;; (define (count sexp sy)
;;  (cond
;;     [(number? sexp) 0]
;;     [(string? sexp) 0]
;;     [(symbol? sexp) (if (equal? sexp sy)
;;                         1
;;                         0)]
;;     [else
;;      (cond
;;        [(empty? sexp) 0]
;;        [else
;;         (+ (count (first sexp) sy)
;;            (count (rest sexp) sy))])]))

(define (count sexp sy)
 (cond
    [(number? sexp) 0]
    [(string? sexp) 0]
    [(symbol? sexp) (if (equal? sexp sy)
                        1
                        0)]
    [else
     (foldr (lambda (fst rst)
              (+ (count fst sy)
                 rst)) 0 sexp)]))
