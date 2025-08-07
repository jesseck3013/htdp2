;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define-struct branch [left right])
 
; A TOS is one of:
; – Symbol
; – (make-branch TOS TOS)
 
; A Direction is one of:
; – 'left
; – 'right
 
; A list of Directions is also called a path.


(define TOS1 (make-branch 'a 'b))
(define TOS2 (make-branch 'c 'd))
(define TOS3 (make-branch TOS1 TOS2))
(define TOS4 (make-branch 'e TOS3))
(define TOS5 (make-branch TOS4 'f))

; TOS [List-of Direction] -> TOS

; Possible inputs and corresponding outpus:
; 1. Symbol '() -> Symbol
; 2. Symbol [List-of Direction] -> Error
; 3. Branch '() -> TOS
; 4. Branch [List-of Direction] -> keep traversing

(check-expect (tree-pick 'x '()) 'x)
(check-error (tree-pick 'x '("left")))
(check-expect (tree-pick TOS1 '()) TOS1)

(check-expect (tree-pick
               TOS5 (list "left" "right" "right"))
              TOS2)

(check-expect (tree-pick
               TOS5 (list "left" "right" "left"))
              TOS1)

(check-error (tree-pick
               TOS5 (list "left" "right" "left" "right" "left")))

(define (tree-pick tree lod)
  (cond
    [(empty? lod) tree]
    [(symbol? tree) ("error: tree walking not finished")]
    [else (if (string=? (first lod) "left")
              (tree-pick (branch-left tree) (rest lod))
              (tree-pick (branch-right tree) (rest lod)))]))

