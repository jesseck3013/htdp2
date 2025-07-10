;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname data_info) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define cham (bitmap "../resources/chameleon.png"))

; A VCham is a structure:
; (make-VCham Number Number String String)
; interpretation (make-VCham x h d c) describes a virtual Cham
; whose x-cordinate is x, hapiness is h, and color is c
(define-struct VCham [x happiness color])

(define BACKGROUND (empty-scene (* (image-width cham) 10)
                                (* (image-height cham) 1.5)))

(define Y-AXIS (/ (image-height BACKGROUND) 2))
(define BG-WIDTH 20)
; VCham -> Image
; render a VCham on an empty background image.
(define (render vCham)
  (beside
   (rectangle BG-WIDTH (VCham-happiness vCham) "solid" "red")
   (place-image
    (overlay cham 
             (rectangle (image-width cham)
                        (image-height cham)
                        "solid"
                        (VCham-color vCham)))
    (VCham-x vCham) Y-AXIS BACKGROUND)))

; VCham -> VCham
; VCham moves 3 pixels right, 
(define (clock-tick-handler Cham)
  (make-VCham
   (modulo (+ (VCham-x Cham) 3) (image-width BACKGROUND))
  (cond
    [(<= (- (VCham-happiness Cham) 0.1) 0) 0]
    [else (- (VCham-happiness Cham) 0.1)])
  (VCham-color Cham)))

(check-expect (clock-tick-handler
               (make-VCham 10 100 "red"))
              (make-VCham 13 99.9 "red"))

(define (should-stop vCham)
  (= (VCham-happiness vCham) 0))

; VCham, String -> VCham
(check-expect (change-color
               (make-VCham 10 10 "red")
               "blue")
              (make-VCham 10 10 "blue"))
(define (change-color vCham color)
  (make-VCham (VCham-x vCham)
             (VCham-happiness vCham)
             color))

; VCham, Number -> VCham
(check-expect (change-happiness
               (make-VCham 10 10 "red")
               8)
              (make-VCham 10 8 "red"))
(define (change-happiness vCham points)
  (make-VCham (VCham-x vCham)
              points
              (VCham-color vCham)))

; VCham, String -> VCham
(check-expect
 (key-handler (make-VCham 10 10 "red") "b")
 (make-VCham 10 10 "blue"))
(define (key-handler vCham ke)
  (cond
    [(string=? ke "r") (change-color vCham "red")]
    [(string=? ke "g") (change-color vCham "green")]
    [(string=? ke "b") (change-color vCham "blue")]
    [(string=? ke "down") (change-happiness
                           vCham
                           (+ (VCham-happiness vCham) 2))]
    [else vCham]))

(define (happy-Cham vCham)
  (big-bang vCham
   [to-draw render]
   [on-tick clock-tick-handler]
   [on-key key-handler]
   [stop-when should-stop]))

(happy-Cham (make-VCham 0 100 "red"))
