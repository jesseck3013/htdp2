;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise298) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

(define-struct no-info [])
(define NONE (make-no-info))
 
(define-struct node [ssn name left right])
; A BT (short for BinaryTree) is one of:
; – NONE
; – (make-node Number Symbol BT BT)

;  15
; /  \
;     24'i

;  15 'd
; /  \
;87'h

(define bt1 (make-node
             15
             'd
             NONE
             (make-node
              24 'i NONE NONE)))

(define bt2 (make-node
             15
             'd
             (make-node
              87 'h NONE NONE)
             NONE))

; BT -? Boolean
(check-expect (contains? NONE 10) #false)
(check-expect (contains? bt1 30) #false)
(check-expect (contains? bt1 24) #true)
(define (contains? bt n)
  (cond
    [(no-info? bt) #false]
    [else (or
           (equal? (node-ssn bt) n)
           (contains? (node-left bt) n)
           (contains? (node-right bt) n))]))
