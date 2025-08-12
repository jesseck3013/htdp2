;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise455) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define-struct transition [current key next])
(define-struct fsm [initial transitions final])
 
; An FSM is a structure:
;   (make-fsm FSM-State [List-of 1Transition] FSM-State)
; A 1Transition is a structure:
;   (make-transition FSM-State 1String FSM-State)
; An FSM-State is String.
 
; data example: see exercise 109
 
(define fsm-a-bc*-d
  (make-fsm
   "AA"
   (list (make-transition "AA" "a" "BC")
         (make-transition "BC" "b" "BC")
         (make-transition "BC" "c" "BC")
         (make-transition "BC" "d" "DD"))
   "DD"))

; FSM String -> Boolean 
; does an-fsm recognize the given string

(define (fsm-match? an-fsm a-string)
  (local (
          (define INIT-STATE (fsm-initial an-fsm))
          (define FINAL-STATE (fsm-final an-fsm))
          (define TABLE (fsm-transitions an-fsm))

          ; String 1String -> String
          (define (next current key)
            (local (
                    (define filtered
                      (filter (lambda (t)
                                (and
                                 (string=?
                                  current
                                  (transition-current t))
                                 (string=? key
                                           (transition-key t))))
                              TABLE))
                    (define found
                      (if (empty? filtered)
                          #false
                          (first filtered)))
                    )
              (if (false? found)
                  current
                  (transition-next found))))
          
           ; FSM-State [List-of 1String] -> Boolean
           (define (helper current keys)
             (cond
               [(empty? keys) (equal? current
                                      FINAL-STATE)]
               [else (helper (next current (first keys))
                             (rest keys))]))
           )
    (helper INIT-STATE (explode a-string))
     ))


(check-expect (fsm-match? fsm-a-bc*-d "abcd") #true)
(check-expect (fsm-match? fsm-a-bc*-d "abc") #false)
(check-expect (fsm-match? fsm-a-bc*-d "abbbbbbbbbbbbbbbbbbbbbcd") #true)

