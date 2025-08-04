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

; BT -> [List-of Number]
(check-expect (inorder NONE) '())
(check-expect (inorder bt1) (list 15 24))
(check-expect (inorder bt2) (list 87 15))
(define (inorder bt)
  (cond
    [(no-info? bt) '()]
    [else
     (append (inorder (node-left bt))
             (list (node-ssn bt))
             (inorder (node-right bt)))]))

; Inorder produces a list of number sorted in ascending order.
