;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname data_info) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; distances in terms of pixels:
(define HEIGHT 200)
(define MIDDLE (quotient HEIGHT 2)) ; 100
(define WIDTH  400)
(define CENTER (quotient WIDTH 2)) ; 200
 
(define-struct game [left-player right-player ball])
(define game0
  (make-game MIDDLE MIDDLE (make-posn CENTER CENTER)))

(game-ball game0)
; (game-ball (make-game MIDDLE MIDDLE (make-posn CENTER CENTER)))
; (game-ball (make-game 100 100 (make-posn 200 200)))
; (make-posn 200 200)

(posn? (game-ball game0))
; (posn? (game-ball (make-game 100 100 (make-posn 200 200))))
; (posn? (make-posn 200 200))
; #true

(game-left-player game0)
; (game-left-player (make-game 100 100 (make-posn 200 200)))
; 100
