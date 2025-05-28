;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname note) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(+ 1 1)
(+ 2 2)

(string-append "hello" "world")
(string-append "hello" " " "world")

(+ (string-length "hello world") 20)

(number->string 42)
(string->number "42")

(string->number "hello world")

(and #true #true)
(and #true #false)
(or #true #false)
(not #false)

(> 10 9)
(< 1 0)
(= 1 1)

(string=? "same" "same")
(string=? "same" "not same")

(define Rocket (bitmap "../resources/rocket.png"))

Rocket

(require 2htdp/image)

(* (image-width Rocket) (image-height Rocket))

(circle 10 "solid" "red")
(rectangle 30 20 "outline" "blue")
(overlay (circle 5 "solid" "red")
         (rectangle 20 20 "solid" "blue"))

(overlay (rectangle 20 20 "solid" "blue")
         (circle 5 "solid" "red"))

(place-image (circle 5 "solid" "green")
             50 80
             (empty-scene 100 100))

(define (y x) (* x x))
(y 1)
(y 2)
(y 3)

(empty-scene 100 60)
(place-image Rocket 50 23 (empty-scene 100 60))
(place-image Rocket 50 30 (empty-scene 100 60))
(place-image Rocket 50 40 (empty-scene 100 60))

(define (picture-of-rocket height)
  (place-image Rocket 50 height (empty-scene 100 60)))


(picture-of-rocket 0)
(picture-of-rocket 10)
(picture-of-rocket 20)
(picture-of-rocket 30)

(require 2htdp/universe)

(define (sign x)
  (cond
    [(> x 0) 1]
    [(= x 0) 0]
    [(< x 0) -1]))

(define (picture-of-rocket.v2 height)
  (cond
    [(<= height 60)
     (place-image Rocket 50 height (empty-scene 100 60))]
    [(> height 60)
     (place-image Rocket 50 60 (empty-scene 100 60))]))

(picture-of-rocket 5555)
(picture-of-rocket.v2 5555)

(define (picture-of-rocket.v3 height)
  (cond
    [(<= height (- 60 (/ (image-height Rocket) 2)))
     (place-image Rocket 50 height
                  (empty-scene 100 60))]
    [(> height (- 60 (/ (image-height Rocket) 2)))
     (place-image Rocket 50 (- 60 (/ (image-height Rocket) 2))
                  (empty-scene 100 60))]))

(picture-of-rocket.v3 5555)

(define HEIGHT 200)
(define WIDTH 400)
(define EMPTY  (empty-scene WIDTH HEIGHT)) ; short for empty scene 
(define X-AXIS 200)
(define ROCKET-CENTER-TO-TOP
  (- HEIGHT (/ (image-height Rocket) 2)))

(define (picture-of-rocket.v4 height)
  (cond
    [(<= height ROCKET-CENTER-TO-TOP)
     (place-image Rocket X-AXIS height
                 EMPTY )]
    [(> height ROCKET-CENTER-TO-TOP)
     (place-image Rocket X-AXIS (- HEIGHT (/ (image-height Rocket) 2))
                  EMPTY)]))

(animate picture-of-rocket.v4)




(define V 3)
     
(define (distance t)
  (* V t))


(define (picture-of-rocket.v6 time)
  (cond
    [(<= (distance time) ROCKET-CENTER-TO-TOP)
     (place-image Rocket X-AXIS (distance time)
                 EMPTY )]
    [(> (distance time) ROCKET-CENTER-TO-TOP)
     (place-image Rocket X-AXIS (- HEIGHT (/ (image-height Rocket) 2))
                  EMPTY)]))
