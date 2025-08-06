;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise349) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; An Xexpr.v2 is a list: 
; – (cons Symbol Body)
; – (cons Symbol (cons [List-of Attribute] Body))
; where Body is short for [List-of Xexpr.v2]
; An Attribute is a list of two items:
;   (cons Symbol (cons String '()))

; Attributes-or-X is one of:
; - [List-of Attribute]
; - Xexpr.v2

; [List-of Attribute] Symbol -> [Maybe String]
(define (find-attr loa s)
  (cond
    [(empty? loa) #false]
    [else
     (local
         (
          (define attr
            (first loa))

          (define attr-name
            (first attr))

          (define attr-value
            (second attr))
          )
       (if (equal? attr-name s)
           attr-value
           (find-attr (rest loa) s)))]))

(define attr1 '((name "Bob")
                (age "10")
                (email "bob@mail.com")))
(check-expect (find-attr attr1 'name) "Bob")
(check-expect (find-attr attr1 'age) "10")
(check-expect (find-attr attr1 'email) "bob@mail.com")
(check-expect (find-attr attr1 'id) #false)
