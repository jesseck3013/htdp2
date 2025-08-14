;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise522) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
; a side a a pair of Number
; (list C M)
; C represents the number of cannibals
; M represents the number of missionaries

; Location is one of:
; - "left"
; - "right"

; a PuzzleState is a structure:
; (make Puzzlestate Side Side Location [List-of PuzzleState])
; - left and right are the number of C and M on each side.
; - boat-loc is Location of the boat
; - path is the list of states that the function has visited started from state0 to the current state.
(define-struct PuzzleState [left right boat-loc path])

(define state0 (make-PuzzleState
                (list 3 3)
                (list 0 0)
                "left"
                '()))

(define state1 (make-PuzzleState
                     (list 1 1)
                     (list 2 2)
                     "left"
                     '()))

(define state-final (make-PuzzleState
                     (list 0 0)
                     (list 3 3)
                     "right"
                     '()))

(define final-puzzle state-final)

(define (final? s1)
  (and (equal? (PuzzleState-left s1)
               (PuzzleState-left state-final))
       (equal? (PuzzleState-right s1)
               (PuzzleState-right state-final))
       (equal? (PuzzleState-boat-loc s1)
               (PuzzleState-boat-loc state-final))))

(define River (empty-scene 100 200))

(define (render-side l)
  (local ((define C (first l))
          (define M (second l))
          (define (render-text type n)
            (text (string-append type ": " (number->string n)) 20 "black"))
          )
    (above 
     (render-text "C" C)
     (render-text "M" M))))

(define MARGIN (rectangle 10 10 "solid" "white"))

(define BOAT (circle 5 "solid" "black"))

(define (render-boat side)  
  (place-image BOAT
               (if (string=? side "left") 10 90)
               (/ (image-height River) 2)
               River))

(define (render-mc s)
  (local ((define LEFT-SIDE (PuzzleState-left s))
          (define RIGHT-SIDE (PuzzleState-right s))
          (define BOAT-SIDE (PuzzleState-boat-loc s)))
    (beside
     (render-side LEFT-SIDE)
     MARGIN
     (render-boat BOAT-SIDE)
     MARGIN
     (render-side RIGHT-SIDE))))

(render-mc state0)
(render-mc state1)
(render-mc state-final)
