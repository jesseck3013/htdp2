;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname data_info) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define BG (empty-scene 90 30))

; A TrafficLight is one of the following strings:
; - GREEN
; - YELLOW
; - RED
(define GREEN "GREEN")
(define YELLOW "YELLOW")
(define RED "RED")
(define TF-ERROR "Invaid value for TrafficLight")

; TrafficLight -> TrafficLight
; yields the next state, given the current state cs
(check-expect (tl-next GREEN) YELLOW)
(check-expect (tl-next YELLOW) RED)
(check-expect (tl-next RED) GREEN)
(check-error (tl-next "fhsdbf") TF-ERROR)
(define (tl-next cs)
  (cond
    [(string=? cs GREEN) YELLOW]
    [(string=? cs YELLOW) RED]
    [(string=? cs RED) GREEN]
    [else (error TF-ERROR)]))

(define ON "ON")
(define OFF "OFF")
(define TrafficLightStateError "Invalid TrafficLightState")
; TrafficLightState is one of the following string:
; - ON
; - OFF

; TrafficLight, TrafficLightState -> Image
; given TrafficLight, render a buld
(check-expect (render-bulb RED ON) (circle 10 "solid" "red"))
(check-expect (render-bulb RED OFF) (circle 10 "outline" "red"))
(check-expect (render-bulb YELLOW ON) (circle 10 "solid" "yellow"))
(check-expect (render-bulb YELLOW OFF) (circle 10 "outline" "yellow"))
(check-expect (render-bulb GREEN ON) (circle 10 "solid" "green"))
(check-expect (render-bulb GREEN OFF) (circle 10 "outline" "green"))
(check-error (render-bulb GREEN "ndkjf0") TrafficLightStateError)
(define (render-bulb tf s)
  (cond
    [(string=? s ON)  (circle 10 "solid" tf)]
    [(string=? s OFF) (circle 10 "outline" tf)]
    [else (error TrafficLightStateError)]))

(define render-red
  (place-image
   (render-bulb GREEN OFF)
   75 15
   (place-image
    (render-bulb YELLOW OFF)
    45 15
    (place-image
     (render-bulb RED ON) 15 15 BG))))

(define render-yellow
  (place-image
   (render-bulb GREEN OFF)
   75 15
   (place-image
    (render-bulb YELLOW ON)
    45 15
    (place-image
     (render-bulb RED OFF) 15 15 BG))))

(define render-green
  (place-image
   (render-bulb GREEN ON)
   75 15
   (place-image
    (render-bulb YELLOW OFF)
    45 15
    (place-image
     (render-bulb RED OFF) 15 15 BG))))

; TrafficLight -> Image
; renders the current state cs as an image
(check-expect (tl-render RED) render-red)
(check-expect (tl-render YELLOW) render-yellow)
(check-expect (tl-render GREEN) render-green)
(define (tl-render cs)
  (cond
    [(string=? cs GREEN) render-green]
    [(string=? cs YELLOW) render-yellow]
    [(string=? cs RED) render-red]
    [else (error TF-ERROR)]))
 
; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))

(traffic-light-simulation GREEN)
