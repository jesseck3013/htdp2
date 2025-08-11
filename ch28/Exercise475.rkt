;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise455) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; A Node is a Symbol.

; A Graph is [List-of [List-of Node]]

(define (neighbors n g)
  (local ((define filtered-list 
            (filter (lambda (node)
                      (equal? (first node) n)) g))
          )
    (rest (first filtered-list))))

(define sample-graph
  '((A B E)
    (B E F)
    (C D)
    (D)
    (E C F)
    (F D G)
    (G)))

(check-expect (neighbors 'A sample-graph) '(B E))
(check-expect (neighbors 'G sample-graph) '())

; Node Node Graph -> [Maybe Path]
; finds a path from origination to destination in G
; if there is no path, the function produces #false
(define (find-path origination destination G)
  (cond
    [(symbol=? origination destination) (list destination)]
    [else (local (

                  ; [List-of Node] -> [Maybe Path]
                  (define (find-path/list lo-Os)
                    (foldr (lambda (node rst)
                             (local ((define candidate (find-path node destination G)))
                             (if (false? candidate)
                                 rst
                                 (find-path node destination G)))) #false lo-Os))

                  (define next (neighbors origination G))
                  (define candidate
                    (find-path/list next)))
            (cond
              [(boolean? candidate) #false]
              [else (cons origination candidate)]))]))

; The function produces this path because it starts searching from first neighbors.

; Graph -> Boolean
(check-expect (other-nodes 'A sample-graph)
              '(B C D E F G))
(define (other-nodes node graph)
  (cond
    [(empty? graph) '()]
    [else (local (
                  (define current-node (first (first graph)))
                  )
            (if (equal? node current-node)
                (other-nodes node (rest graph))
                (cons current-node
                      (other-nodes node (rest graph)))))]))

; [List-of Symbol] [List-of Symbol] -> Boolean
(define (same-elements l1 l2)
  (local (
          (define (remove s l)
            (filter (lambda (item)
                      (not (equal? item s))) l))
          )
    (cond
      [(empty? l1) (empty? l2)]
      [else (and (member? (first l1) l2)
                 (same-elements (rest l1)
                                (remove (first l1) l2)))])))

(check-expect (same-elements '(A B) '(B A))
              #true)
(check-expect (same-elements '(A B C) '(B A C))
              #true)

; Graph -> Boolean
(define (test-on-all-nodes g)
  (cond
    [(empty? g) #true]
    [else
     (andmap
      (lambda (current-node)
        (same-elements (neighbors current-node g)
                       (other-nodes current-node g)))
      (foldr (lambda (item rst)
               (cons (first item) rst)) '() g))]))

(check-expect (test-on-all-nodes '()) #true)
(check-expect (test-on-all-nodes '((A))) #true)
(check-expect (test-on-all-nodes '((A B)
                                   (B A))) #true)
(check-expect (test-on-all-nodes '((A B C)
                                   (B A C)
                                   (C A B))) #true)
(check-expect (test-on-all-nodes '((A B C D)
                                   (B A C D)
                                   (C A B D)
                                   (D C A B))) #true)

(check-expect (test-on-all-nodes '((A B C)
                                   (B A)
                                   (C A B))) #false)

(check-expect (test-on-all-nodes '((A B C)
                                   (B A C)
                                   (C A A))) #false)
(define cyclic-graph
  '((A B E)
    (B E F)
    (C B D)
    (D)
    (E C F)
    (F D G)
    (G)))

(find-path 'B 'C cyclic-graph)
; (B E C)

(check-expect (test-on-all-nodes cyclic-graph) #false)
; I've addressed the infinite loop issue. The original solution is expected to be non-stop.
