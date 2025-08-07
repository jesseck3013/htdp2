;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; An XMachine is a nested list of this shape:
;   (cons 'machine (cons `((initial ,FSM-State)) [List-of X1T]))

; List Version:
;; (cons 'machine (cons (list (list 'initial FSM-State))
;;                      [List-of X1T]))

;; Cons Version:
;; (cons 'machine
;;       (cons (cons (cons 'initial (cons FSM-State '())) '())
;;             [List-of X1T]))

;-------------------------------------------------------------

; An X1T is a nested list of this shape:
;   `(action ((state ,FSM-State) (next ,FSM-State)))

; List Version
;(list 'action (list (list 'state FSM-State)) (list 'next FSM-State))

; Cons Version
;; (cons 'action
;;       (cons
;;        (cons (cons 'state
;;                    (cons FSM-State '()))
;;              '())
;;        (cons
;;         (cons 'next (cons FSM-State '()))
;;         '())))
