;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise298) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

(define-struct no-info [])
(define NONE (make-no-info))
 
(define-struct node [ssn name left right])
; A BT (short for BinaryTree) is one of:
; – NONE
; – (make-node Number Symbol BT BT)

(define bt1 (make-node
             15
             'd
             NONE
             (make-node
              24 'i NONE NONE)))

; BT -> [List-of Number]
(check-expect (inorder NONE) '())
(check-expect (inorder bt1) (list 15 24))
(define (inorder bt)
  (cond
    [(no-info? bt) '()]
    [else
     (append (inorder (node-left bt))
             (list (node-ssn bt))
             (inorder (node-right bt)))]))

; BST Number Symbol -> BST
(define (create-bst b n s)
  (cond
    [(no-info? b) (make-node n s NONE NONE)]
    [else
     (local (
             (define (insert-right b)
               (make-node (node-ssn b)
                          (node-name b)
                          (node-left b)
                          (create-bst (node-right b) n s)))

             (define (insert-left b)
               (make-node (node-ssn b)
                          (node-name b)
                          (create-bst (node-left b) n s)
                          (node-right b)))
             )
       (cond
         [(>= (node-ssn b) n) (insert-left b)]
         [else (insert-right b)]))]))

; [List-of [List-of Number Symbol]] -> BST
(define (create-bst-from-list lons)
  (cond
    [(empty? lons) NONE]
    [else (create-bst
           (create-bst-from-list (rest lons))
           (first (first lons))
           (second (first lons))
           )]))

(define input '((99 o)
                (77 l)
                (24 i)
                (10 h)
                (95 g)
                (15 d)
                (89 c)
                (29 b)
                (63 a)))

;; (check-expect (inorder (create-bst-from-list input))
;;               (list 10 15 24 29 63 77 89 95 99))


(define (create-bst-from-list-foldr lons)
  (foldr (lambda (pair rst)
           (create-bst
            rst
            (first pair)
            (second pair))) NONE lons))

;; (check-expect (inorder (create-bst-from-list-foldr input))
;;               (list 10 15 24 29 63 77 89 95 99))

(define (create-bst-from-list-foldl lons)
  (foldl (lambda (pair rst)
           (create-bst
            rst
            (first pair)
            (second pair))) NONE lons))

;; (check-expect (inorder (create-bst-from-list-foldl input))
;;               (list 10 15 24 29 63 77 89 95 99))

(node-ssn (create-bst-from-list-foldr input)) ; 63
(node-ssn (create-bst-from-list-foldl input)) ; 99

; The sequence of processing matters.
; The same list of number might be represented by more than one BST structures.
