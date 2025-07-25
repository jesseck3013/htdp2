;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |11|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define-struct gp [name score])
; A GamePlayer is a structure: 
;    (make-gp String Number)
; interpretation (make-gp p s) represents player p who 
; scored a maximum of s points

(define GP1 (make-gp "player1" 1))
(define GP2 (make-gp "player2" 2))
(define GP3 (make-gp "player3" 3))
(define GP4 (make-gp "player4" 4))

(define unsorted-list (list GP2 GP4 GP3 GP1))
(define sorted-list (list GP4 GP3 GP2 GP1))

; List-of-GamePlayer -> List-of-GamePlayer
; return #true if the l is sorted by gp's score in a descending order.
(check-expect (sorted? unsorted-list) #false)
(check-expect (sorted? sorted-list) #true)
(define (sorted? l)
  (cond
    [(empty? (rest l)) #true]
    [else (and (> (gp-score (first l))
                  (gp-score (first (rest l))))
               (sorted? (rest l)))]))

; List-of-GamePlayer -> List-of-GamePlayer
; sort the list by gp's score in a descending order.
(check-expect (sort-gp> '()) '())
(check-satisfied (sort-gp> unsorted-list) sorted?)
(check-satisfied (sort-gp> sorted-list) sorted?)

(define (sort-gp> l)
  (cond
    [(empty? l) '()]
    [else (insert (first l)
                  (sort-gp> (rest l)))]))


; GamePlayer List-of-GamePlayer -> List-of-GamePlayer
(check-expect (insert GP3 sorted-list)
              (list GP4 GP3 GP3 GP2 GP1))
(check-expect (insert GP1 sorted-list)
              (list GP4 GP3 GP2 GP1 GP1))
(check-expect (insert GP1 '())
              (list GP1))

(define (insert p gpl)
  (cond
    [(empty? gpl) (cons p gpl)]
    [else (if (has-higher-score
               p
               (first gpl))
              (cons p gpl)
              (cons (first gpl)
                    (insert p (rest gpl))))]))

; GamePlayer GamePlayer -> Boolean
(check-expect (has-higher-score GP1 GP2) #false)
(check-expect (has-higher-score GP3 GP2) #true)
(define (has-higher-score gp1 gp2)
  (> (gp-score gp1)
     (gp-score gp2)))
