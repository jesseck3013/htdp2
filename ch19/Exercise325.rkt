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

; BT Number -> Symbol
(check-expect (search-bst NONE 10) NONE)
(check-expect (search-bst bt1 24) 'i)
(define (search-bst bt target)
  (cond
    [(no-info? bt) NONE]
    [else
     (cond
       [(equal? (node-ssn bt) target)
        (node-name bt)]
       [(> target (node-ssn bt))
        (search-bst (node-right bt) target)]
       [else (search-bst (node-left bt) target)])]))


; With the extra information from BST, the search function eliminate one extra recursive call every time a non-NONE BT is passed in the function.
