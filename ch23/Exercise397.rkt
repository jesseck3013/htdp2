;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define-struct card-record [No hours])

(define-struct employee [name No rate])

(define-struct wage-record [name amount])

; (define ERROR "employee not found")

; [List-of employee] [List-of card-record] -> [List-of wage-record]

(define e1 (make-employee "e1" 1 10))
(define e2 (make-employee "e2" 2 12))
(define e3 (make-employee "e3" 3 14))

(define c1 (make-card-record 1 10))
(define c2 (make-card-record 2 12))
(define c3 (make-card-record 3 14))

(check-expect
 (wages*.v3 (list e1 e2 e3) (list c1 c2 c3))
 (list
  (make-wage-record "e1" 100)
  (make-wage-record "e2" 144)
  (make-wage-record "e3" 196)))

(check-error
 (wages*.v3 (list e1 e2 e3) (list c1 c2)))

(define (wages*.v3 loe loc)
  (cond
    [(empty? loe) '()]
    [else
     (local (
             (define e (first loe))
             (define name (employee-name e))
             (define wage (get-wage e loc))
             )
     (cons
      (make-wage-record name wage)
      (wages*.v3 (rest loe) loc)))]))

; employee [List-of card-record] -> Number
(check-expect (get-wage e1 (list c1 c2 c3))
              100)
(check-error (get-wage e1 (list c2 c3)))

(define (get-wage e loc)
  (local (
          (define name (employee-name e))
          (define no (employee-No e))
          (define rate (employee-rate e))

          (define ERROR
            (string-append
             "Time card record is not found. "
             "Employee: "
             name
             ", Card No: "
             (number->string no)
             ))
          )
  (cond
    [(empty? loc) (error ERROR)]
    [(equal? no (card-record-No (first loc)))
     (* rate (card-record-hours (first loc)))]
    [else (get-wage e (rest loc))])))
