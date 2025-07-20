 ;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise97) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define GREEN-LIGHT (bitmap "../resources/pedestrian_traffic_light_green.png"))
(define RED-LIGHT (bitmap "../resources/pedestrian_traffic_light_red.png"))

; TrafficLight is a structure
; (make-TrafficLight String Number)
; Interpretation: (make-TrafficLight t c) means 
; the image is t and the count down number is c,
; where t can be one of:
; - red
; - green
; - countDown
; c is a positive integer within this interval [0, 9]
(define-struct TrafficLight [type count])

(define FONT-SIZE 48)
(define DEFAULT (make-TrafficLight "red" 0))
(define GREEN-5 (make-TrafficLight "green" 5))
(define COUNT-DOWN-ODD (make-TrafficLight "countDown" 5))
(define COUNT-DOWN-EVEN (make-TrafficLight "countDown" 4))
; TrafficLight ->  Image
; render the image based on the given TrafficLight state
(check-expect (render DEFAULT) RED-LIGHT)
(check-expect (render GREEN-5) GREEN-LIGHT)
(check-expect (render COUNT-DOWN-ODD)
              (text "5" FONT-SIZE "orange"))
(check-expect (render COUNT-DOWN-EVEN)
              (text "4" FONT-SIZE "green"))
(define (render tl)
  (cond
    [(string=? (TrafficLight-type tl) "red") RED-LIGHT]
    [(string=? (TrafficLight-type tl) "green") GREEN-LIGHT]
    [(string=? (TrafficLight-type tl) "countDown")
     (text (number->string (TrafficLight-count tl))
           FONT-SIZE
           (if (even? (TrafficLight-count tl))
               "green"
               "orange"))]))

(define GREEN-0 (make-TrafficLight "green" 0))
(define COUNT-DOWN-ZERO (make-TrafficLight "countDown" 0))
; TrafficLight -> TrafficLight
; clock tick event handler
(check-expect (clock-tick-handler DEFAULT) DEFAULT)
(check-expect (clock-tick-handler GREEN-5)
              (make-TrafficLight "green" 4))
(check-expect (clock-tick-handler GREEN-5)
              (make-TrafficLight "green" 4))
(check-expect (clock-tick-handler GREEN-0)
              (make-TrafficLight "countDown" 9))
(check-expect (clock-tick-handler COUNT-DOWN-ODD)
              (make-TrafficLight "countDown" 4))
(check-expect (clock-tick-handler COUNT-DOWN-ZERO)
              (make-TrafficLight "red" 0))

(define (clock-tick-handler tl)
  (cond
    [(string=? (TrafficLight-type tl) "red") tl]
    [(string=? (TrafficLight-type tl) "green")
     (if (= (TrafficLight-count tl) 0)
         (make-TrafficLight "countDown" 9)
         (make-TrafficLight "green"
                            (- (TrafficLight-count tl) 1)))]
    [(string=? (TrafficLight-type tl) "countDown")
     (if (= (TrafficLight-count tl) 0)
         (make-TrafficLight "red" 0)
         (make-TrafficLight
          "countDown"
          (- (TrafficLight-count tl) 1)))]))

; TrafficLight String -> TrafficLight
; key event handler
(check-expect (key-handler DEFAULT " ")
              (make-TrafficLight "green" 9))
(check-expect (key-handler GREEN-5 " ")
              (make-TrafficLight "green" 9))
(check-expect (key-handler COUNT-DOWN-ODD " ")
              (make-TrafficLight "green" 9))
(define (key-handler tl ke)
  (cond
    [(string=? ke " ") (make-TrafficLight "green" 9)]
    [else tl]))

; starting point of the world program
(big-bang DEFAULT
          [to-draw render]
          [on-tick clock-tick-handler 1]
          [on-key key-handler])
