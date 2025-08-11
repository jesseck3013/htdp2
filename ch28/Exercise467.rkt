;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise455) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define M ; an SOE 
  (list (list 2 2  3 10) ; an Equation 
        (list 2 5 12 31)
        (list 4 1 -2  1)))
 
(define S '(1 1 2)) ; a Solution

; Equation -> [List-of Number]
; extracts the left-hand side from a row in a matrix
(check-expect (lhs (first M)) '(2 2 3))
(define (lhs e)
  (reverse (rest (reverse e))))

; Equation -> Number
; extracts the right-hand side from a row in a matrix
(check-expect (rhs (first M)) 10)
(define (rhs e)
  (first (reverse e)))

; SOE Solution -> Boolean
(define (check-solution soe lon)
  (local (
          (define (plug-in coefficients values)
            (cond
              [(empty? coefficients) 0]
              [else (+
                     (*
                      (first coefficients)
                      (first values))
                     (plug-in (rest coefficients)
                                    (rest values)))]))
          
          (define (check-equation coefficients result)
            (= (plug-in coefficients lon)
               result))
          )
    (cond
      [(empty? soe) #true]
      [else
       (and (check-equation (lhs (first soe))
                            (rhs (first soe)))
            (check-solution (rest soe) lon))])))

(check-satisfied S (lambda (s)
                     (check-solution M s)))

(define M2 ; an SOE 
  (list (list 2 2  3 10) ; an Equation 
        (list 0 3 9 21)
        (list 0 -3 -8  -19)))

(check-satisfied S (lambda (s)
                     (check-solution M2 s)))

; An Equation is [List-of Number]

; Equation Equation -> Equation
(define (subtract e1 e2)
  (local (
          (define multiple (/
                            (first e1)
                            (first e2)))

          (define (helper e1 e2)
            (cond
              [(empty? e1) '()]
              [else (cons
                     (- (first e1)
                        (* multiple (first e2)))
                     (helper (rest e1) (rest e2)))]))
          )
    (if (= 0 (first e2))
        (rest e2)
        (helper (rest e1) (rest e2)))))

(check-expect (subtract '(3 9 21) '(-3 -8 -19))
              '(1 2))

(check-expect (subtract '(0 -5 -5) '(-8 -4 -12))
              '(-5 -5))

; SOE -> TM
; triangulates the given system of equations 
(define (triangulate M)
  (local (
          ; Equation [List-of Euqation] -> [List-of Equation]
          (define (subtract-equations e equations)
            (cond
              [(empty? equations) '()]
              [else
               (cons (subtract (first equations) e)
                     (subtract-equations e
                                         (rest equations)))]))
          )
  (cond
    [(empty? M) '()]
    [else
     (local (
             (define first-e (first M))
             (define (rotate L)
               (append (rest L) (list (first L))))
             
             (define checked-M
               (if (zero? (first first-e))
                   (rotate M)
                   M))
             )
       (cons (first checked-M)
             (triangulate
              (subtract-equations (first checked-M)
                                  (rest checked-M)))))])))

(define m1 (list (list  3  9 21)
                 (list -3 -8 -19)))

(define m2 (list (list  3  9 21)
                 (list     1 2)))

(define m3 (list (list 2  3  3 8)
                 (list 2  3 -2 3)
                 (list 4 -2  2 4)))

(define m4 (list (list 2  3  3   8)
                 (list   -8 -4 -12)
                 (list      -5  -5)))

(check-expect (triangulate m1) m2)
(check-expect (triangulate m3) m4)

; it does not termiate for all SOE. because it can keep rotating when all first element is 0.
