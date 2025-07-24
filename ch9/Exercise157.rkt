;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise153) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define HEIGHT 220) ; distances in terms of pixels 
(define WIDTH 30)
(define XSHOTS (random (/ WIDTH 2)))
 
; graphical constants 
(define BACKGROUND (rectangle WIDTH HEIGHT "solid" "green"))
(define SHOT (rectangle 1 3 "solid" "red"))

; A List-of-shots is one of: 
; – '()
; – (cons Shot List-of-shots)
; interpretation the collection of shots fired 

; A Shot is a Number.
; interpretation represents the shot's y-coordinate

; A ShotWorld is List-of-numbers. 
; interpretation each number on such a list
;   represents the y-coordinate of a shot 

; ShotWorld -> Image
; adds the image of a shot for each  y on w 
; at (MID,y) to the background image
(check-expect (to-image (cons 9 '()))
              (place-image SHOT XSHOTS 9 BACKGROUND))
(check-expect (to-image (cons 1 (cons 9 '())))
              (place-image SHOT XSHOTS 1(place-image SHOT XSHOTS 9 BACKGROUND)))
(define (to-image w)
  (cond
    [(empty? w) BACKGROUND]
    [else (place-image SHOT XSHOTS (first w)
                       (to-image (rest w)))]))

; ShotWorld -> ShotWorld 
(define (main w0)
  (big-bang w0
    [on-tick tock]
    [on-key keyh]
    [to-draw to-image]))
 
; ShotWorld -> ShotWorld 
; moves each shot up by one pixel
(check-expect (tock '()) '())
(check-expect (tock (cons 10 '())) (cons 9 '()))
(check-expect (tock (cons 20 (cons 10 '()))) (cons 19 (cons 9 '())))
(define (tock w)
  (cond
    [(empty? w) '()]
    [else (cons (sub1 (first w)) (tock (rest w)))]))
 
; ShotWorld KeyEvent -> ShotWorld 
; adds a shot to the world if the space bar is hit
(check-expect (keyh '() " ") (cons HEIGHT '()))
(check-expect (keyh (cons 10 '()) " ") (cons HEIGHT
                                             (cons 10 '())))
(define (keyh w ke)
  (if (key=? ke " ") (cons HEIGHT w) w))

(main '())
