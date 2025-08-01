;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise246) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; FSM FSM-State -> FSM-State
; matches the keys pressed by a player with the given FSM 
(define (simulate fsm s0)
  (local (; State of the World: FSM-State
          ; FSM-State KeyEvent -> FSM-State
          (define (find-next-state s key-event)
            (find fsm s)))
    (big-bang s0
      [to-draw state-as-colored-square]
      [on-key find-next-state])))
 
; FSM-State -> Image
; renders current state as colored square 
(define (state-as-colored-square s)
  (square 100 "solid" s))
 
; FSM FSM-State -> FSM-State
; finds the current state's successor in fsm
(define (find transitions current)
  (cond
    [(empty? transitions) (error "not found")]
    [else
      (local ((define s (first transitions)))
        (if (state=? (transition-current s) current)
            (transition-next s)
            (find (rest transitions) current)))]))
