;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise45) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define cat1 (bitmap "../resources/cat1.png"))
(define cat2 (bitmap "../resources/cat2.png"))

; WorldState: cw is the happiness gauge
; the range of cw is [0, 100]

; WorldState -> WorldState
; for each tick of the clock, big-bang obtains the next 
; state of the world from (clock-tick-handler cw) 
(define (clock-tick-handler cw)
  (cond
    [(<= (- cw 0.1) 0) 0]
    [else (- cw 0.1)]))
(check-expect (clock-tick-handler 10) 9.9)
(check-expect (clock-tick-handler 2.5) 2.4)

; WorldState, KeyEvent -> WorldState
; when key is "down", cw decreases by 1/5
; when key is "up", cw increases by 1/3
(define (key-handler cw key)
  (cond
    [(string=? key "down") (* cw (/ 4 5))]
    [(string=? key "up") (* cw (/ 4 3))]
    [else cw]))

(check-expect (key-handler 100 "down") 80)
(check-expect (key-handler 3 "up") 4)

(define BG-WIDTH 20)
(define BG-HEIGHT 100)
(define BACKGROUND (empty-scene BG-WIDTH BG-HEIGHT))

; WorldState -> Image
; when needed, big-bang obtains the image of the current 
; state of the world by evaluating (render cw) 
(define (render cw)
  (place-image (rectangle BG-WIDTH cw "solid" "red")
               (/ BG-WIDTH 2) (- BG-HEIGHT (/ cw 2)) BACKGROUND))

(define (gauge-prog cw)
  (big-bang cw
   [to-draw render]
   [on-tick clock-tick-handler]
   [on-key key-handler]))

(gauge-prog 100)
