;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |25.1|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; List-of-numbers -> List-of-numbers
; produces a sorted version of l
(define (sort> l)
  (cond
    [(empty? l) '()]
    [(cons? l) (insert (first l) (sort> (rest l)))]))
 
; Number List-of-numbers -> List-of-numbers
; inserts n into the sorted list of numbers l 
(define (insert n l)
  (cond
    [(empty? l) (cons n '())]
    [else (if (>= n (first l))
              (cons n l)
              (cons (first l) (insert n (rest l))))]))

(define (sort< l)
  (reverse (sort> l)))

; [List-of Number] -> [List-of Number]
; produces a sorted version of alon
; assume the numbers are all distinct 
(define (quick-sort< alon)
  (cond
    [(empty? alon) '()]
    [(empty? (rest alon)) alon]
    [else (local ((define pivot (first alon)))
            (append (quick-sort< (smallers alon pivot))
                    (equals alon pivot)
                    (quick-sort< (largers alon pivot))))]))

; [List-of Number] Number -> [List-of Number]
; Create a list where all elements are from alon, and
; all elements are larger than n
(define (largers alon n)
  (cond
    [(empty? alon) '()]
    [else (if (> (first alon) n)
              (cons (first alon) (largers (rest alon) n))
              (largers (rest alon) n))]))

; [List-of Number] Number -> [List-of Number]
; Create a list where all elements are from alon, and
; all elements are smaller than n
(define (smallers alon n)
  (cond
    [(empty? alon) '()]
    [else (if (< (first alon) n)
              (cons (first alon) (smallers (rest alon) n))
              (smallers (rest alon) n))]))

; [List-of Number] Number -> [List-of Number]
; Create a list where all elements are from alon, and
; all elements are equal to n.
(define (equals alon n)
  (cond
    [(empty? alon) '()]
    [else (if (= (first alon) n)
              (cons (first alon) (equals (rest alon) n))
              (equals (rest alon) n))]))

; Basic examples
(check-expect (quick-sort< '()) '())
(check-expect (quick-sort< '(1)) '(1))
(check-expect (quick-sort< '(4 9 6 2)) '(2 4 6 9))
(check-expect (quick-sort< '(4 9 6 2 2)) '(2 2 4 6 9))
(check-expect (sort< '()) '())
(check-expect (sort< '(1)) '(1))
(check-expect (sort< '(4 9 6 2 2)) '(2 2 4 6 9))

; N -> [List-of Number]
; Generate a list of random numbers in the range of [0, len - 1] with len length.
(define (create-tests len)
  (local (
          (define (generate-list n)
            (build-list n (lambda (item)
                              (random (add1 item))))
            )

          (define (create-tests-reverse len)
            (cond
              [(= 1 len) (list (generate-list 1))]
              [else (cons
                     (generate-list len)
                     (create-tests-reverse (/ len 2)))]))
          )
    (if (= (remainder len 2) 0)
        (reverse (create-tests-reverse len))
        (error "Please only provide a multiple of 2"))))

(define cases1 (create-tests (expt 2 13)))

(define (benchmark test-cases func)
  (local (
          (define (hide-result expr case)
            (number->string (length case)))

          (define (measure-time case)
            (time (hide-result (func case) case)))
          )
    (map measure-time test-cases)))

(benchmark cases1 quick-sort<)
;; length 1:    cpu time: 0 real time: 0 gc time: 0
;; length 2:    cpu time: 0 real time: 0 gc time: 0
;; length 4:    cpu time: 0 real time: 0 gc time: 0
;; length 8:    cpu time: 0 real time: 0 gc time: 0
;; length 16:   cpu time: 0 real time: 0 gc time: 0
;; length 32:   cpu time: 0 real time: 0 gc time: 0
;; length 64:   cpu time: 0 real time: 0 gc time: 0
;; length 128:  cpu time: 1 real time: 1 gc time: 0
;; length 256:  cpu time: 3 real time: 3 gc time: 0
;; length 512:  cpu time: 13 real time: 13 gc time: 0
;; length 1024: cpu time: 39 real time: 39 gc time: 0
;; length 2048: cpu time: 110 real time: 110 gc time: 2
;; length 4096: cpu time: 334 real time: 334 gc time: 12
;; length 8192: cpu time: 817 real time: 817 gc time: 1

(benchmark cases1 sort<)
;; length 1:    cpu time: 0 real time: 0 gc time: 0
;; length 2:    cpu time: 0 real time: 0 gc time: 0
;; length 4:    cpu time: 0 real time: 0 gc time: 0
;; length 8:    cpu time: 0 real time: 0 gc time: 0
;; length 16:   cpu time: 0 real time: 0 gc time: 0
;; length 32:   cpu time: 0 real time: 0 gc time: 0
;; length 64:   cpu time: 0 real time: 0 gc time: 0
;; length 128:  cpu time: 2 real time: 2 gc time: 0
;; length 256:  cpu time: 10 real time: 10 gc time: 0
;; length 512:  cpu time: 42 real time: 42 gc time: 0
;; length 1024: cpu time: 170 real time: 170 gc time: 0
;; length 2048: cpu time: 673 real time: 673 gc time: 1
;; length 4096: cpu time: 2776 real time: 2776 gc time: 17
;; length 8192: cpu time: 11165 real time: 11169 gc time: 35

; Based on the above testing result, when the length of the list is small (below 128), I didn't find that sort< is better then quick-sort< though, their performance does not differ.

; When the length grows to 256, sort< is significantly slower than quick-sort<. On my machine, it is (/ 3 10) = 3.33 times slower. As the length grows, the performance varies rapidly.
