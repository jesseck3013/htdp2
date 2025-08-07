;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(require 2htdp/abstraction)

; An FSM is a [List-of 1Transition]
; A 1Transition is a list of three items:
; (cons FSM-State (cons FSM-State (cons [List-of KeyEvents] h'()))
; An FSM-State is a String that specifies a color
 
; data examples 
(define fsm-traffic
  '(("red" "green"
           ("g"))
    ("green" "yellow"
             ("y"))
    ("yellow" "red"
              ("r"))))
 
; FSM FSM-State -> FSM-State 
; matches the keys pressed by a player with the given FSM 
(define (simulate transitions state0)
  (big-bang state0 ; FSM-State
    [to-draw
     (lambda (current)
       (overlay (text current 12 "black")
                (square 100 "solid" current)))]
    [on-key
     (lambda (current key-event)
       (local (
               (define keys (find-keys transitions current))
               )
         (if (member? key-event keys)
             (find transitions current)
             current)))]))
 
; [X Y] [List-of [List X Y]] X -> Y
; finds the matching Y for the given X in alist
(check-expect
 (find fsm-traffic "red") "green")
(check-expect
 (find fsm-traffic "green") "yellow")
(check-expect
 (find fsm-traffic "yellow") "red")
(check-error
 (find fsm-traffic "gjkbnvkb"))
(define (find alist x)
  (local ((define fm (assoc x alist)))
    (if (cons? fm) (second fm) (error "not found"))))

; [X Y] [List-of [List X Y]] X -> Y
; finds the matching Y for the given X in alist
(check-expect
 (find-keys fsm-traffic "red") (list "g"))
(check-expect
 (find-keys fsm-traffic "green") (list "y"))
(check-expect
 (find-keys fsm-traffic "yellow") (list "r"))
(check-error
 (find-keys fsm-traffic "gjkbnvkb"))
(define (find-keys alist x)
  (local ((define fm (assoc x alist)))
    (if (cons? fm) (third fm) (error "not found"))))

(simulate fsm-traffic "red")
