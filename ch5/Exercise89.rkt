;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname data_info) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define cat1 (bitmap "../resources/cat1.png"))

; A VCat is a structure:
; (make-VCat Number Number)
; interpretation (make-VCat x h) describes a virtual cat
; whose x-cordinate is x and its hapiness is h.
(define-struct VCat [x happiness])

(define BACKGROUND (empty-scene (* (image-width cat1) 10)
                                (* (image-height cat1) 1.5)))

(define Y-AXIS (/ (image-height BACKGROUND) 2))

(define BG-WIDTH 20)
; VCat -> Image
; render a VCat on an empty background image.
(define (render vcat)
  (beside
   (rectangle BG-WIDTH (VCat-happiness vcat) "solid" "red")
   (place-image cat1 (VCat-x vcat) Y-AXIS BACKGROUND)))

; VCat -> VCat
; VCat moves 3 pixels right, 
(define (clock-tick-handler cat)
  (make-VCat
   (modulo (+ (VCat-x cat) 3)
           (image-width BACKGROUND))
  (cond
    [(<= (- (VCat-happiness cat) 0.1) 0) 0]
    [else (- (VCat-happiness cat) 0.1)])))

(check-expect (clock-tick-handler (make-VCat 10 100))
              (make-VCat 13 99.9))

(define (happy-cat vcat)
  (big-bang vcat
   [to-draw render]
   [on-tick clock-tick-handler]))

(happy-cat (make-VCat 0 100))
