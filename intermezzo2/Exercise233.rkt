;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname quote) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))

(define q1 `(0 ,@'(1 2 3) 4))
(define l1 (list 0 1 2 3 4))
(check-expect q1 l1)

(define q2 `(("alan" ,(* 2 500))
             ("barb" 2000)
             (,@'("carl" " , the great")   1500)
             ("dawn" 2300)))
(define l2 (list
            (list "alan" 1000)
            (list "barb" 2000)
             (list "carl" " , the great"   1500)
             (list "dawn" 2300)))
(check-expect q2 l2)

; List-of-numbers -> ... nested list ...
; creates a row for an HTML table from l
(define (make-row l)
  (cond
    [(empty? l) '()]
    [else (cons (make-cell (first l))
                (make-row (rest l)))]))

; Number -> ... nested list ...
; creates a cell for an HTML table from a number 
(define (make-cell n)
  `(td ,(number->string n)))

(define q3 `(html
             (body
              (table ((border "1"))
                     (tr ((width "200"))
                         ,@(make-row '( 1  2)))
                     (tr ((width "200"))
                         ,@(make-row '(99 65)))))))

; (make-row '( 1  2)) -> (list `(td "1") `(td "2"))

(define l3 (list `html
             (list `body
              (list `table (list (list `border "1"))
                    (list `tr (list (list `width "200"))
                         `(td "1") `(td "2"))
                    (list `tr (list (list `width "200"))
                          `(td "99") `(td "65"))))))
(check-expect q3 l3)
