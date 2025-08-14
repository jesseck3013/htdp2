;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |33.1|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; A Lam is one of: 
; – a Symbol
; – (list 'λ (list Symbol) Lam)
; – (list Lam Lam)

(define ex1 '(λ (x) x))
(define ex2 '(λ (x) y))
(define ex3 '(λ (y) (λ (x) y)))
(define ex4 '((λ (x) (x x)) (λ (x) (x x))))

; Lam -> Boolean
(check-expect (is-var? 'x) #true)
(check-expect (is-var? ex1) #false)
(define (is-var? x)
  (symbol? x))

; Lam -> Boolean
(check-expect (is-λ? 'x) #false)
(check-expect (is-λ? ex1) #true)
(check-expect (is-λ? ex2) #true)
(check-expect (is-λ? ex3) #true)
(check-expect (is-λ? ex4) #false)
(define (is-λ? l)
  (cond
    [(is-var? l) #false]
    [else (equal? (first l) 'λ)]))

; Lam -> Boolean
(check-expect (is-app? 'x) #false)
(check-expect (is-app? ex1) #false)
(check-expect (is-app? ex2) #false)
(check-expect (is-app? ex3) #false)
(check-expect (is-app? ex4) #true)
(define (is-app? l)
  (and
   (not (is-var? l))
   (not (is-λ? l))))

; Lam -> (List Symbol)
(check-expect (λ-para ex1) 'x)
(define (λ-para l)
  (first (second l)))

; Lam -> Lam
(check-expect (λ-body ex1) 'x)
(check-expect (λ-body ex2) 'y)
(define (λ-body l)
  (third l))

; Lam -> Lam
(check-expect (app-fun ex4) '(λ (x) (x x)))
(define (app-fun l)
  (first l))

; Lam -> Lam
(check-expect (app-arg ex4) '(λ (x) (x x)))
(define (app-arg l)
  (second l))

; Lam -> [List-of symbols]
(define (declareds l)
  (cond
    [(is-var? l) '()]
    [(is-λ? l) (cons (λ-para l)
                       (declareds (λ-body l)))]
    [else (append (declareds (first l))
                  (declareds (second l)))]))

(check-expect (declareds ex1) '(x))
(check-expect (declareds ex2) '(x))
(check-expect (declareds ex3) '(y x))
(check-expect (declareds ex4) '(x x))


; Lam -> Lam 
; replaces all symbols s in le with '*undeclared
; if they do not occur within the body of a λ 
; expression whose parameter is s
 
(check-expect (undeclareds ex1) ex1)
(check-expect (undeclareds ex2) '(λ (x) *undeclared))
(check-expect (undeclareds ex3) ex3)
(check-expect (undeclareds ex4) ex4)
 
; Lam -> Lam 
(define (undeclareds le0)
  (local (; Lam [List-of Symbol] -> Lam
          ; accumulator declareds is a list of all λ 
          ; parameters on the path from le0 to le
          (define (undeclareds/a le declareds)
            (cond
              [(is-var? le)
               (if (member? le declareds) le '*undeclared)]
              [(is-λ? le)
               (local ((define para (λ-para le))
                       (define body (λ-body le))
                       (define newd (cons para declareds)))
                 (list 'λ (list para)
                   (undeclareds/a body newd)))]
              [(is-app? le)
               (local ((define fun (app-fun le))
                       (define arg (app-arg le)))
               (list (undeclareds/a fun declareds)
                     (undeclareds/a arg declareds)))])))
    (undeclareds/a le0 '())))

(define ex5 '((λ (x) x) x))
(check-expect (undeclareds ex5)
              '((λ (x) x) *undeclared))

(define ex6 '(λ (*undeclared) ((λ (x) (x *undeclared)) y)))

(check-expect (undeclareds ex6)
              '(λ (*undeclared) ((λ (x) (x *undeclared)) *undeclared)))

; Lam -> Lam 
(define (undeclareds-modified le0)
  (local (; Lam [List-of Symbol] -> Lam
          ; accumulator declareds is a list of all λ 
          ; parameters on the path from le0 to le
          (define (undeclareds/a le declareds)
            (cond
              [(is-var? le)
               (if (member? le declareds)
                   (list '*declared le)
                   (list '*undeclared 'x))]
              [(is-λ? le)
               (local ((define para (λ-para le))
                       (define body (λ-body le))
                       (define newd (cons para declareds)))
                 (list 'λ (list para)
                   (undeclareds/a body newd)))]
              [(is-app? le)
               (local ((define fun (app-fun le))
                       (define arg (app-arg le)))
               (list (undeclareds/a fun declareds)
                     (undeclareds/a arg declareds)))])))
    (undeclareds/a le0 '())))

(undeclareds-modified ex1)
(undeclareds-modified ex2)
(undeclareds-modified ex3)
(undeclareds-modified ex4)
(undeclareds-modified ex5)
(undeclareds-modified ex6)
