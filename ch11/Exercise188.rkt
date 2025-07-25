;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |11|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define-struct email [from date message])
; An Email Message is a structure: 
;   (make-email String Number String)
; interpretation (make-email f d m) represents text m 
; sent by f, d seconds after the beginning of time 

(define EMAIL1 (make-email "player1" 1 "message 1"))
(define EMAIL2 (make-email "player2" 2 "message 2"))
(define EMAIL3 (make-email "player3" 3 "message 3"))
(define EMAIL4 (make-email "player4" 4 "message 4"))

(define unsorted-list (list EMAIL2 EMAIL4 EMAIL3 EMAIL1))
(define sorted-list (list EMAIL4 EMAIL3 EMAIL2 EMAIL1))

; List-of-Email -> List-of-Email
; return #true if the l is sorted by email's score in a descending order.
(check-expect (sorted? unsorted-list) #false)
(check-expect (sorted? sorted-list) #true)
(define (sorted? l)
  (cond
    [(empty? (rest l)) #true]
    [else (and (> (email-date (first l))
                  (email-date (first (rest l))))
               (sorted? (rest l)))]))

; List-of-Email -> List-of-Email
; sort the list by email's score in a descending order.
(check-expect (sort-email> '()) '())
(check-satisfied (sort-email> unsorted-list) sorted?)
(check-satisfied (sort-email> sorted-list) sorted?)

(define (sort-email> l)
  (cond
    [(empty? l) '()]
    [else (insert (first l)
                  (sort-email> (rest l)))]))


; Email List-of-Email -> List-of-Email
(check-expect (insert EMAIL3 sorted-list)
              (list EMAIL4 EMAIL3 EMAIL3 EMAIL2 EMAIL1))
(check-expect (insert EMAIL1 sorted-list)
              (list EMAIL4 EMAIL3 EMAIL2 EMAIL1 EMAIL1))
(check-expect (insert EMAIL1 '())
              (list EMAIL1))

(define (insert p emaill)
  (cond
    [(empty? emaill) (cons p emaill)]
    [else (if (has-higher-date
               p
               (first emaill))
              (cons p emaill)
              (cons (first emaill)
                    (insert p (rest emaill))))]))

; Email Eamil -> Boolean
(check-expect (has-higher-date EMAIL1 EMAIL2) #false)
(check-expect (has-higher-date EMAIL3 EMAIL2) #true)
(define (has-higher-date email1 email2)
  (> (email-date email1)
     (email-date email2)))

; email email -> Boolean
(check-expect (name>? EMAIL1 EMAIL2) #false)
(check-expect (name>? EMAIL4 EMAIL2) #true)
(define (name>? email1 email2)
  (string>? (email-from email1)
            (email-from email2)))

; Email List-of-Email -> List-of-Email
; insert email by name's alphabetical order

(check-expect (insert EMAIL3 sorted-list)
              (list EMAIL4 EMAIL3 EMAIL3 EMAIL2 EMAIL1))
(check-expect (insert EMAIL1 sorted-list)
              (list EMAIL4 EMAIL3 EMAIL2 EMAIL1 EMAIL1))
(check-expect (insert EMAIL1 '())
              (list EMAIL1))

(define (insert-name p emaill)
  (cond
    [(empty? emaill) (cons p emaill)]
    [else (if (has-higher-date
               p
               (first emaill))
              (cons p emaill)
              (cons (first emaill)
                    (insert p (rest emaill))))]))

; List-of-emails -> List-of-emails
(check-expect (sort-by-name> '()) '())
(check-expect (sort-by-name> (list EMAIL1 EMAIL2 EMAIL3))
              (list EMAIL3 EMAIL2 EMAIL1))
(define (sort-by-name> l)
  (cond
    [(empty? l) '()]
    [else (insert-name (first l)
                       (sort-email> (rest l)))]))
