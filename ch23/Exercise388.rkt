;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; Employee is a structure:
; (make-employee String Number Number)
(define-struct employee [name ssn rate])

(define e1 (make-employee "e1" 1 10))
(define e2 (make-employee "e2" 2 15))
(define e3 (make-employee "e3" 3 12))
(define el (list e1 e2 e3))

; Record is a structure:
; (make-record String Number)
(define-struct work-record [name hours])

(define r1 (make-work-record "e1" 10))
(define r2 (make-work-record "e2" 5))
(define r3 (make-work-record "e3" 8))
(define rl (list r1 r2 r3))

; Wage is a structure:
; (make-wage String Number)
(define-struct wage [name amount])
(define w1 (make-wage "e1" 100))
(define w2 (make-wage "e2" 75))
(define w3 (make-wage "e3" 96))

; [List-of Employee] [List-of Record] -> [List-of Wage]
(check-expect (wages*.v3 el rl) (list w1 w2 w3))

(define (wages*.v3 loe lor)
  (cond
    [(empty? loe) '()]
    [else
     (local (
             (define e (first loe))
             (define r (first lor))
             (define wage
               (* (employee-rate e)
                  (work-record-hours r)))
             (define e-name (employee-name
                             e))
             )
       (cons
        (make-wage e-name wage)
        (wages*.v3 (rest loe) (rest lor))))]))
