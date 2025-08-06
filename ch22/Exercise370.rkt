;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise349) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(require 2htdp/abstraction)

; An Xexpr.v2 is a list: 
; – (cons Symbol Body)
; – (cons Symbol (cons [List-of Attribute] Body))
; where Body is short for [List-of Xexpr.v2]
; An Attribute is a list of two items:
;   (cons Symbol (cons String '()))

; Attributes-or-X is one of:
; - [List-of Attribute]
; - Xexpr.v2

; An XWord is '(word ((text String))).

; Examples:

(define w1 '(word ((text "item 1"))))
(define w2 '(word ((text "item 2"))))
(define w3 '(word ((text ""))))

; ISL+ value -> Boolean
(check-expect (word? w1) #true)
(check-expect (word? w2) #true)
(check-expect (word? w3) #true)
(check-expect (word? 10) #false)
(check-expect (word? "xx") #false)
(check-expect (word? 'x) #false)
(check-expect (word? '(word)) #false)
(check-expect (word? '(word ((txt "hhh")))) #false)

(define (word? value)
  (cond
    [(atom? value) #false]
    [(empty? value) #false]
    [(empty? (rest value)) #false]
    [(not
      (list-of-attributes? (second value)))
     #false]
    [else (and
           (equal? (first value) 'word)
           (string? (find-attr
                     (second value) 'text)))]))

; Word -> String
(check-expect (word-text w1) "item 1")
(check-expect (word-text w2) "item 2")
(check-expect (word-text w3) "")
(define (word-text w)
  (local ((define attributes (second w)))
    (find-attr attributes 'text)))

; ISL+ value -> Boolean
(define (atom? value)
  (not (cons? value)))

; [List-of Attribute] or Xexpr.v2 -> Boolean
; is x a list of attributes
(define (list-of-attributes? x)
  (cond
    [(empty? x) #true]
    [else
     (local ((define possible-attribute (first x)))
       (cons? possible-attribute))]))

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

