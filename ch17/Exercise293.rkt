;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise265) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; X [List-of X] -> [Maybe [List-of X]]
; returns the first sublist of l that starts
; with x, #false otherwise
(define (find x l)
  (cond
    [(empty? l) #false]
    [else
     (if (equal? (first l) x) l (find x (rest l)))]))


(define l1 (list
            "apple"
            "orange"
            "juice"))
(check-satisfied (find "apple" l1)
                 (found? "apple" l1))

; [Maybe X] [ [Maybe X] [Maybe X] -> Boolean]
(define (found? target orignal-list)
  (lambda (lox)
    (cond
      [(boolean? lox) (not (member? target orignal-list))]
      [else (and
             (equal? (first lox) target)
             (sublist? lox orignal-list)
             )])
    ))

; [X] [List-of X] [List-of X] -> Boolean 
; check is sub is a sublist of main
(check-expect (sublist? (list 3 4 5) (list 1 2 3 4 5))
              #true)
(check-expect (sublist? '() (list 1 2 3 4 5))
              #true)
(define (sublist? sub main)
  (cond
    [(empty? main) (empty? sub)]
    [(equal? sub main) #true]
    [else
     (or (equal? sub (rest main))
         (sublist? sub (rest main)))]))

