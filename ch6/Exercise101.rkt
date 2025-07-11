 ;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise97) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; MissileOrNot Image -> Image 
; adds an image of missile m to scene s 
(define (missile-render.v2 m s)
  s)

; use empty scene to represent a scene that contains a ufo and a tank
(define scene (empty-scene 100 100)) 
(check-expect (missile-render.v2 #false s) s)
(check-expect (missile-render.v2
               (make-posn
                32
                (- HEIGHT
                   TANK-HEIGHT
                   10))
               (place-image MISSLE (- HEIGHT
                                      TANK-HEIGHT
                                      10) empty-scene)))
