;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise5) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(require 2htdp/image)

(define tree-height 100)
(define tree-width 50)
(define triangle-side-length tree-width)
(define rectangle-width (/ tree-width 4))
(define rectangle-height (/ tree-height 2))

(place-image
 (triangle triangle-side-length "solid" "green")
 50 50
 (place-image (rectangle rectangle-width rectangle-height "solid" "tan")
              50 85
              (empty-scene 100 100)))


