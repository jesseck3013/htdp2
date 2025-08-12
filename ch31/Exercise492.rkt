;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise489) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define (neighbors n g)
  (local ((define filtered-list 
            (filter (lambda (node)
                      (equal? (first node) n)) g))
          )
    (rest (first filtered-list))))

; Node Node Graph -> [Maybe Path]
; finds a path from origination to destination in G
; if there is no path, the function produces #false
(define (find-path origination destination G)
  (local (
          (define (helper origination destination G seen)
            (cond
              [(symbol=? origination destination) (list destination)]
              [(member? origination seen) #false]
              [else (local ((define next (neighbors origination G)) ; [List-of symbol]
                            (define candidate
                              (find-path/list next destination G (cons origination seen))))
                      (cond
                        [(boolean? candidate) #false]
                        [else (cons origination candidate)]))]))

          (define (find-path/list lo-Os D G seen)
            (cond
              [(empty? lo-Os) #false]
              [else (local ((define candidate
                              (helper (first lo-Os) D G seen)))
                      (cond
                        [(boolean? candidate)
                         (find-path/list (rest lo-Os) D G seen)]
                        [else candidate]))]))

          )
  (helper origination destination G '())
  )) 

(define cyclic-graph
  '((A B E)
    (B E F)
    (C B D)
    (D)
    (E C F)
    (F D G)
    (G)))

(check-expect (find-path 'A 'D cyclic-graph) '(A B E C D))
