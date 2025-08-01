;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |12.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))

; FSM-State is one of:
; - AA
; - BB
; - DD
; - ER
(define AA "start, expect and a")
(define BB "expect 'b', 'c', or 'd'")
(define DD "finished")
(define ER "error, illegal key")

(define-struct ktransition [current key next])
; A Transition.v2 is a structure:
;   (make-ktransition FSM-State KeyEvent FSM-State)

(define states109
  (list
   (make-ktransition AA "a" BB)
   (make-ktransition BB "b" BB)
   (make-ktransition BB "c" BB)
   (make-ktransition BB "d" DD)
   (make-ktransition DD "d" DD)))

; State -> Image
; Render the image based on the given State
(check-expect (render AA) (rectangle 100 100 "solid" "white"))
(check-expect (render BB) (rectangle 100 100 "solid" "yellow"))
(check-expect (render DD) (rectangle 100 100 "solid" "green"))
(check-expect (render ER) (rectangle 100 100 "solid" "red"))
(define (render s)
  (cond
    [(string=? s AA) (rectangle 100 100 "solid" "white")]
    [(string=? s BB) (rectangle 100 100 "solid" "yellow")]
    [(string=? s DD) (rectangle 100 100 "solid" "green")]
    [(string=? s ER) (rectangle 100 100 "solid" "red")]))

; WorldState is a structure
; (make-struct List-of-ktransition FSM-State)
(define-struct WorldState [fsm current])

; WorldState -> Image
(check-expect (render-ws (make-WorldState states109 AA))
              (render AA))
(define (render-ws ws)
  (render (WorldState-current ws)))

; WorldState -> WorldState
(define (find-next-state ws ke)
  (cond
    [(empty?
      (WorldState-fsm ws))
     (make-WorldState (WorldState-fsm ws) ER)]
    [else
     (if (and
          (first-item-key-is ws ke)
          (first-item-current-match ws))
         (make-WorldState (WorldState-fsm ws) (ktransition-next (first (WorldState-fsm ws))))
         (find-next-state
          (make-WorldState (rest (WorldState-fsm ws))
                           (WorldState-current ws))
          ke))]))

; WorldState String -> Boolean
(define (first-item-key-is ws ke)
  (string=? (ktransition-key (first (WorldState-fsm ws)))
            ke))

(define (first-item-current-match ws)
  (string=? (ktransition-current (first (WorldState-fsm ws)))
            (WorldState-current ws)))

; FSM FSM-State -> SimulationState
; match the keys pressed with the given FSM 
(define (simulate an-fsm s0)
  (big-bang (make-WorldState an-fsm s0)
            [to-draw render-ws]
            [on-key find-next-state]))

(simulate states109 AA)
