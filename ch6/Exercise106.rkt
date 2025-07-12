 ;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise97) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define cham (bitmap "../resources/chameleon.png"))
(define cat1 (bitmap "../resources/cat1.png"))

; A VCham is a structure:
; (make-VCham Number Number String String)
; interpretation (make-VCham x h d c) describes a virtual Cham
; whose x-cordinate is x, hapiness is h, and color is c
(define-struct VCham [x happiness color])

; VCham -> Image
; render a VCham on an empty background image.
(define (render-cham vCham)
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
(define (clock-tick-handler-cham Cham)
  (make-VCham
   (modulo (+ (VCham-x Cham) 3) (image-width BACKGROUND))
  (cond
    [(<= (- (VCham-happiness Cham) 0.1) 0) 0]
    [else (- (VCham-happiness Cham) 0.1)])
  (VCham-color Cham)))

(check-expect (clock-tick-handler-cham
               (make-VCham 10 100 "red"))
              (make-VCham 13 99.9 "red"))

(define (should-stop-cham vCham)
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
 (key-handler-cham (make-VCham 10 10 "red") "b")
 (make-VCham 10 10 "blue"))
(define (key-handler-cham vCham ke)
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
   [to-draw render-cham]
   [on-tick clock-tick-handler-cham]
   [on-key key-handler-cham]
   [stop-when should-stop-cham]))

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
(define (render-cat vcat)
  (beside
   (rectangle BG-WIDTH (VCat-happiness vcat) "solid" "red")
   (place-image cat1 (VCat-x vcat) Y-AXIS BACKGROUND)))

; VCat -> VCat
; VCat moves 3 pixels right, 
(define (clock-tick-handler-cat cat)
  (make-VCat
   (modulo (+ (VCat-x cat) 3)
           (image-width BACKGROUND))
  (cond
    [(<= (- (VCat-happiness cat) 0.1) 0) 0]
    [else (- (VCat-happiness cat) 0.1)])))

(check-expect (clock-tick-handler-cat (make-VCat 10 100))
              (make-VCat 13 99.9))

; VCham, String -> VCham
(check-expect
 (key-handler-cat (make-VCat 10 9) "up")
 (make-VCat 10 12))
(check-expect
 (key-handler-cat (make-VCat 10 10) "down")
 (make-VCat 10 8))
(define (key-handler-cat vcat ke)
  (cond
    [(string=? ke "up") (make-VCat (VCat-x vcat)
                                   (* (VCat-happiness vcat)
                                      (+ 1 (/ 1 3))))]
    [(string=? ke "down") (make-VCat (VCat-x vcat)
                                   (* (VCat-happiness vcat)
                                      (- 1 (/ 1 5))))]
    [else vcat]))

(define (should-stop-cat vcat)
  (= (VCat-happiness vcat) 0))

(define (happy-cat vcat)
  (big-bang vcat
   [to-draw render-cat]
   [on-tick clock-tick-handler-cat]
   [stop-when should-stop-cat]))

; VAnimal is either
; - a VCat
; - a VCham

; VAnimal -> Image
(define (render animal)
  (cond
    [(VCat? animal) (render-cat  animal)]
    [(VCham? animal) (render-cham animal)]))

; VAnimal -> VAnimal
(define (tick-handler animal)
  (cond
    [(VCat? animal) (clock-tick-handler-cat animal)]
    [(VCham? animal) (clock-tick-handler-cham animal)]))

; VAnimal String -> VAnimal
(define (key-handler animal ke)
    (cond
    [(VCat? animal) (key-handler-cat animal ke)]
    [(VCham? animal) (key-handler-cham animal ke)]))
