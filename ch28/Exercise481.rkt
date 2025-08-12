;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise455) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; QP QP -> Boolean
(define (threatening? qp1 qp2)
  (local (
          (define x1 (posn-x qp1))
          (define y1 (posn-y qp1))
          (define x2 (posn-x qp2))
          (define y2 (posn-y qp2))
          )
    (or (= x1 x2)
        (= y1 y2)
        (= (- x2 x1)
           (- y2 y1)))))

(check-expect (threatening? (make-posn 0 0)
                            (make-posn 1 1))
              #true)

(check-expect (threatening? (make-posn 0 0)
                            (make-posn 0 1))
              #true)

(check-expect (threatening? (make-posn 0 0)
                            (make-posn 1 0))
              #true)

(check-expect (threatening? (make-posn 0 0)
                            (make-posn 2 1))
              #false)

; [List-of QP] -> Boolean
(define (threaten-each-other solution)
  (local (
          (define (get-other-qps qp solution)
            (cond
              [(empty? solution) '()]
              [(equal? qp (first solution))
               (get-other-qps qp (rest solution))]
              [else (cons (first solution)
                          (get-other-qps qp (rest solution)))]))
          )
    (andmap (lambda (qp)
              (andmap (lambda (other)
                        (threatening? qp other))
                      (get-other-qps qp solution)))
            solution)))

; N -> [[List-of QP] -> Boolean]
(define (n-queens-solutions? n)
  (lambda (solution)
    (and (= n (length solution))
         (not (threaten-each-other solution)))))

(define 0-1 (make-posn 0 1))
(define 1-3 (make-posn 1 3))
(define 2-0 (make-posn 2 0))
(define 3-2 (make-posn 3 2))
 
(define solution-4-1 (list 0-1 1-3 2-0 3-2))
(define solution-4-2 (list 1-3 2-0 0-1 3-2))

(check-satisfied solution-4-1 (n-queens-solutions? 4))
(check-satisfied solution-4-2 (n-queens-solutions? 4))

; [X] [List-of X] [List-of X] -> Boolean
(define (set=? l1 l2)
  (local (
          (define (remove s l)
            (filter (lambda (item)
                      (not (equal? item s))) l))
          )
    (cond
      [(empty? l1) (empty? l2)]
      [(not (= (length l1) (length l2))) #false]
      [else (and (member? (first l1) l2)
                 (set=? (rest l1)
                                (remove (first l1) l2)))])))

(check-expect (set=? '(A B) '(B A))
              #true)
(check-expect (set=? '(A B C) '(B A C))
              #true)

(check-expect (set=? solution-4-1 solution-4-2) #true)

(check-expect (set=? solution-4-1 (cons 0-1
                                        solution-4-2)) #false)

(check-expect (set=? '() '()) #true)
(check-expect (set=? '() '(1)) #false)
