;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise94) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define BG (empty-scene 500 300))

(define UFO (ellipse 60 30 "solid" "purple"))

(define TANK (rectangle 30 10 "solid" "green"))

(define MISSILE (rectangle 10 10 "solid" "black"))

(place-image 
 MISSILE
 30 200
 (place-image TANK 50 (- 300 (/ (image-height TANK) 2)) (overlay UFO BG)))
