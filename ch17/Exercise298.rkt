;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise298) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

(define ROCKET (bitmap "../resources/rocket.png"))

; An ImageStream is a function: 
;   [N -> Image]
; interpretation a stream s denotes a series of images

; ImageStream
(define (create-rocket-scene height)
  (place-image ROCKET 50 height (empty-scene 60 60)))

; [Number -> Image] Number -> Image
(define (my-animate s n)
  (big-bang 0
            [to-draw s]
            [on-tick add1 (/ 1 30)]
            [stop-when (lambda (x) (>= x n))]))

(my-animate create-rocket-scene 1000)

