;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; data examples 
(define fsm-traffic
  '(("red" "green"
           ("g"))
    ("green" "yellow"
             ("y"))
    ("yellow" "red"
              ("r"))))

; XML Configuration:

;; <machine initial="black">
;; <action state="black" next="white" />
;; <action state="white" next="black" />
;; </machine>

; XMachine representation:
(define BW-Xmachine
  '(machine ((initial "black"))
            (action ((state "black") (next "white")))
            (action ((state "white") (next "black")))))

; XMachine -> FSM-State 
; interprets the given configuration as a state machine 
(define (simulate-xmachine xm)
  (simulate (xm->transitions xm) (xm-state0 xm)))
; XMachine -> FSM-State 
; extracts and translates the transition table from xm0
 
(check-expect (xm-state0 xm0) "red")
 
(define (xm-state0 xm0)
  (find-attr (xexpr-attr xm0) 'initial))
 
; XMachine -> [List-of 1Transition]
; extracts the transition table from xm
 
(check-expect (xm->transitions xm0) fsm-traffic)
 
(define (xm->transitions xm)
  (local (; X1T -> 1Transition
          (define (xaction->action xa)
            (list (find-attr (xexpr-attr xa) 'state)
                  (find-attr (xexpr-attr xa) 'next))))
    (map xaction->action (xexpr-content xm))))

; FSM FSM-State -> FSM-State 
; matches the keys pressed by a player with the given FSM 
(define (simulate transitions state0)
  (big-bang state0 ; FSM-State
    [to-draw
      (lambda (current)
        (square 100 "solid" current))]
    [on-key
      (lambda (current key-event)
        (find transitions current))]))

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

; [List-of Attribute] Symbol -> [Maybe String]
(define (find-attr loa s)
  (cond
    [(empty? loa) #false]
    [else
     (local
         (
          (define attr
            (first loa))

          (define attr-name
            (first attr))

          (define attr-value
            (second attr))
          )
       (if (equal? attr-name s)
           attr-value
           (find-attr (rest loa) s)))]))

; Xexpr.v2 -> [List-of Attribute]
; retrieves the list of attributes of xe
(define (xexpr-attr xe)
  (local ((define optional-loa+content (rest xe)))
    (cond
      [(empty? optional-loa+content) '()]
      [else
       (local ((define loa-or-x
                 (first optional-loa+content)))
         (if (list-of-attributes? loa-or-x)
             loa-or-x
             '()))])))

; [List-of Attribute] or Xexpr.v2 -> Boolean
; is x a list of attributes
(define (list-of-attributes? x)
  (cond
    [(empty? x) #true]
    [else
     (local ((define possible-attribute (first x)))
       (cons? possible-attribute))]))

(define (xexpr-content xe)
  (local (
          (define optional-loa+content (rest xe))
          ; output is one of:
          ; - '()
          ; - Xexpr.v2
          ; - (cons [list-of-attributes] Xexpr.v2)

          ; [list-of-attributes] or Xexpr.v2 -> Boolean
          (define (content? x)
            (cond
              [(empty? x) #false]
              [else (local (
                            (define loa-or-x (first x))
                            )
                      (symbol? loa-or-x))]))

          (define get-content
            (cond
              [(empty? optional-loa+content)
               '()]
              [else (local (
                            (define attributes-or-x
                              (first optional-loa+content))
                            )
                      (if (content? attributes-or-x)
                          optional-loa+content
                          (rest optional-loa+content)))]))
          ) 
  get-content))
 
(simulate-xmachine BW-Xmachine)
