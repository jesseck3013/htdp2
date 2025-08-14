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
                     "right"
                     '()))

(define state2 (make-PuzzleState
                     (list 0 1)
                     (list 3 2)
                     "left"
                     '()))

(define state-final (make-PuzzleState
                     (list 0 0)
                     (list 3 3)
                     "right"
                     '()))

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

; Puzzlestate Puzzlestate -> Boolean
(define (same-state s seen)
            (and
             (equal? (PuzzleState-left s) (PuzzleState-left seen))
             (equal? (PuzzleState-right s) (PuzzleState-right seen))
             (equal? (PuzzleState-boat-loc s) (PuzzleState-boat-loc seen))))

; PuzzleState -> Boolean
; Check if a state has been reached before
(define (circular? s)
  (local (
          (define PATH (PuzzleState-path s))
          
          )
    (ormap (lambda (seen) (same-state s seen)) PATH)))

; PuzzleState -> Boolean
(define (invalid? s)
  (local ((define LEFT (PuzzleState-left s))
          (define RIGHT (PuzzleState-right s))
          (define (C-will-eat side)
            (and (> (second side) 0)
                (> (first side)
                   (second side)))))
    (cond
      [(< (first LEFT) 0) #true]
      [(< (second LEFT) 0) #true]
      [(< (first RIGHT) 0) #true]
      [(< (second RIGHT) 0) #true]
      [(C-will-eat LEFT) #true]
      [(C-will-eat RIGHT) #true]
      [else (circular? s)])))

(check-expect (invalid? state0) #false)
(check-expect (invalid? state1) #false)
(check-expect (invalid? state2) #true)
(check-expect (invalid? state-final) #false)
(check-expect (invalid? (make-PuzzleState (list -1 3)
                                          (list 4 0)
                                          "right"
                                          '())) #true)
(check-expect (invalid? (make-PuzzleState (list 3 -1)
                                          (list 0 4)
                                          "right"
                                          '())) #true)

(check-expect (invalid? (make-PuzzleState (list 1 1)
                                          (list 2 2)
                                          "right"
                                          (list (make-PuzzleState (list 1 1)
                                                                  (list 2 2)
                                                                  "right"
                                                                  '())))) #true)
; Puzzlestate -> Boolean
(define (valid? s)
  (not (invalid? s)))

; Puzzlestate -> [List-of PuzzleState]
(define (create-next-states s)
  (local (
          (define BOAT-SIDE (PuzzleState-boat-loc s))
          )
    (cond
      [(string=? BOAT-SIDE "left")
       (filter valid? (move-right s))]
      [(string=? BOAT-SIDE "right")
       (filter valid? (move-left s))])))

(check-expect (create-next-states state0) (list state0-right-C-1
                                                state0-right-C-2
                                                state0-right-M-1-C-1))

; Puzzlestate -> [List-of Puzzlestate]
(define (move-right s)
  (local (
          (define LEFT-SIDE (PuzzleState-left s))
          (define LEFT-C (first LEFT-SIDE))
          (define LEFT-M (second LEFT-SIDE))

          (define RIGHT-SIDE (PuzzleState-right s))
          (define RIGHT-C (first RIGHT-SIDE))
          (define RIGHT-M (second RIGHT-SIDE))

          (define PATH (PuzzleState-path s))

          (define M-1 (make-PuzzleState (list LEFT-C (sub1 LEFT-M))
                                        (list RIGHT-C (add1 RIGHT-M))
                                        "right"
                                        (cons s PATH)))
          (define M-2 (make-PuzzleState (list LEFT-C (- LEFT-M 2))
                                        (list RIGHT-C (+ RIGHT-M 2))
                                        "right"
                                        (cons s PATH)))
          (define C-1 (make-PuzzleState (list (sub1 LEFT-C)  LEFT-M)
                                        (list (add1 RIGHT-C) RIGHT-M)
                                        "right"
                                        (cons s PATH)))
          (define C-2 (make-PuzzleState (list (- LEFT-C 2)  LEFT-M)
                                        (list (+ RIGHT-C 2) RIGHT-M)
                                        "right"
                                        (cons s PATH)))
          (define M-1-C-1 (make-PuzzleState (list (sub1 LEFT-C)  (sub1 LEFT-M))
                                            (list (add1 RIGHT-C) (add1 RIGHT-M))
                                            "right"
                                            (cons s PATH)))
          )
  (list M-1 M-2 C-1 C-2 M-1-C-1)))

(define state1-left-M-1 (make-PuzzleState
                         (list 1 2)
                         (list 2 1)
                         "left"
                         `(,state1)))
(define state1-left-M-2 (make-PuzzleState
                         (list 1 3)
                         (list 2 0)
                         "left"
                         `(,state1)))
(define state1-left-C-1 (make-PuzzleState
                         (list 2 1)
                         (list 1 2)
                         "left"
                         `(,state1)))
(define state1-left-C-2 (make-PuzzleState
                         (list 3 1)
                         (list 0 2)
                         "left"
                         `(,state1)))
(define state1-left-M-1-C-1 (make-PuzzleState
                             (list 2 2)
                             (list 1 1)
                             "left"
                             `(,state1)))

(check-expect (move-left state1) (list state1-left-M-1
                                       state1-left-M-2
                                       state1-left-C-1
                                       state1-left-C-2
                                       state1-left-M-1-C-1))


; Puzzlestate -> [List-of Puzzlestate]
(define (move-left s)
  (local (
          (define LEFT-SIDE (PuzzleState-left s))
          (define LEFT-C (first LEFT-SIDE))
          (define LEFT-M (second LEFT-SIDE))

          (define RIGHT-SIDE (PuzzleState-right s))
          (define RIGHT-C (first RIGHT-SIDE))
          (define RIGHT-M (second RIGHT-SIDE))

          (define PATH (PuzzleState-path s))

          (define M-1 (make-PuzzleState (list LEFT-C (add1 LEFT-M))
                                        (list RIGHT-C (sub1 RIGHT-M))
                                        "left"
                                        (cons s PATH)))
          (define M-2 (make-PuzzleState (list LEFT-C (+ LEFT-M 2))
                                        (list RIGHT-C (- RIGHT-M 2))
                                        "left"
                                        (cons s PATH)))
          (define C-1 (make-PuzzleState (list (add1 LEFT-C)  LEFT-M)
                                        (list (sub1 RIGHT-C) RIGHT-M)
                                        "left"
                                        (cons s PATH)))
          (define C-2 (make-PuzzleState (list (+ LEFT-C 2)  LEFT-M)
                                        (list (- RIGHT-C 2) RIGHT-M)
                                        "left"
                                        (cons s PATH)))
          (define M-1-C-1 (make-PuzzleState (list (add1 LEFT-C)  (add1 LEFT-M))
                                            (list (sub1 RIGHT-C) (sub1 RIGHT-M))
                                            "left"
                                            (cons s PATH)))
          )
  (list M-1 M-2 C-1 C-2 M-1-C-1)))

(define state0-right-M-1 (make-PuzzleState
                       (list 3 2)
                       (list 0 1)
                       "right"
                       `(,state0)))

(define state0-right-M-2 (make-PuzzleState
                           (list 3 1)
                           (list 0 2)
                           "right"
                           `(,state0)))

(define state0-right-C-1 (make-PuzzleState
                           (list 2 3)
                           (list 1 0)
                           "right"
                           `(,state0)))

(define state0-right-C-2 (make-PuzzleState
                           (list 1 3)
                           (list 2 0)
                           "right"
                           `(,state0)))

(define state0-right-M-1-C-1 (make-PuzzleState
                              (list 2 2)
                              (list 1 1)
                              "right"
                              `(,state0)))

(check-expect (move-right state0) (list state0-right-M-1
                                        state0-right-M-2
                                        state0-right-C-1
                                        state0-right-C-2
                                        state0-right-M-1-C-1))


; PuzzleState -> PuzzleState
; is the final state reachable from state0
; generative creates a tree of possible boat rides 
; termination ???

(define initial-puzzle state0)
(define final-puzzle state-final)
 
(check-expect (same-state (goto-final initial-puzzle) final-puzzle) #true)
 
(define (goto-final state0)
  (local (; [List-of PuzzleState] -> PuzzleState
          ; generative generates the successors of los
          (define (solve* los)
            (cond
              [(ormap final? los)
               (first (filter final? los))]
              [else
               (solve* (foldr (lambda (s rst)
                                (append (create-next-states s)
                                        rst)) '() los))])))
     (solve* (list state0))))


; Puzzlestate -> [List-of Puzzlestate]
(define (solve state0)
  (local (
          (define path (PuzzleState-path (goto-final state0)))
          (define (clear-nested path)
            (map (lambda (s)
                   (make-PuzzleState
                    (PuzzleState-left s)
                    (PuzzleState-right s)
                    (PuzzleState-boat-loc s)
                    '())) path))
          )
  (reverse (cons final-puzzle (clear-nested path)))))

(solve state0)
; output:
;; (#(struct:PuzzleState (3 3) (0 0) "left" ())
;;  #(struct:PuzzleState (1 3) (2 0) "right" ())
;;  #(struct:PuzzleState (2 3) (1 0) "left" ())
;;  #(struct:PuzzleState (0 3) (3 0) "right" ())
;;  #(struct:PuzzleState (1 3) (2 0) "left" ())
;;  #(struct:PuzzleState (1 1) (2 2) "right" ())
;;  #(struct:PuzzleState (2 2) (1 1) "left" ())
;;  #(struct:PuzzleState (2 0) (1 3) "right" ())
;;  #(struct:PuzzleState (3 0) (0 3) "left" ())
;;  #(struct:PuzzleState (1 0) (2 3) "right" ())
;;  #(struct:PuzzleState (1 1) (2 2) "left" ())
;;  #(struct:PuzzleState (0 0) (3 3) "right" ()))
