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

(define-struct fsm [initial transitions final])
(define-struct transition [current key next])
; An FSM.v2 is a structure: 
;   (make-fsm FSM-State LOT FSM-State)
; A LOT is one of: 
; – '() 
; – (cons Transition.v3 LOT)
; A Transition.v3 is a structure: 
;   (make-transition FSM-State KeyEvent FSM-State)

; 
(define Transitions-230
  (list
   (make-transition AA "a" BB)
   (make-transition BB "b" BB)
   (make-transition BB "c" BB)
   (make-transition BB "d" DD)
   (make-transition DD "d" DD)))

; FSM.v2 -> Boolean
(check-expect (should-stop
               (make-fsm AA Transitions-230 ER)) #false)
(define (should-stop fsmv2)
  (string=? (fsm-initial fsmv2)
            (fsm-final fsmv2)))

; FSM.v2 -> Image
(check-expect (render-fsmv2 (make-fsm AA Transitions-230 ER))
              (render AA))
(define (render-fsmv2 fsmv2)
  (render (fsm-initial fsmv2)))

; FSM.v2 -> FSM.v2
(define (find-next-state fsmv2 ke)
  (make-fsm
   (find (fsm-initial fsmv2) ke (fsm-transitions fsmv2))
   (fsm-transitions fsmv2)
   (fsm-final fsmv2)
   ))

; FSM-state String LOT -> FSM-state
(check-expect (find AA "a" Transitions-230)
              BB)
(check-expect (find AA "b" Transitions-230)
              ER)
(define (find s ke lot)
  (cond
    [(empty? lot) ER]
    [(and
      (string=? s (transition-current (first lot)))
      (string=? ke (transition-key (first lot))))
     (transition-next (first lot))]
    [else (find s ke (rest lot))]))

(define (fsm-simulate fsmv2)
  (big-bang fsmv2
   [to-draw render-fsmv2]
   [on-key find-next-state]
   [stop-when should-stop render-fsmv2]))

(define INIT (make-fsm AA Transitions-230 ER))

(fsm-simulate INIT)
