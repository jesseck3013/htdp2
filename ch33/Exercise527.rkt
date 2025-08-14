;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise527) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define MT (empty-scene 400 400))
(define MIN-LENGTH 10)

; Number Number Number Number -> Posn
(define (find-posn base-x base-y len angle)
  (local (
          (define radian (* (/ angle 180) pi))
          (define complex (make-polar len radian))
          )
    (make-posn (- base-x (real-part complex))
               (- base-y (imag-part complex)))
    ))

; Number Number Number Number -> Image
(define (add-savannah img x y len angle)
  (local (
          (define p2 (find-posn x y len angle))
          (define p3 (find-posn x y (* len 1/3) angle))
          (define p4 (find-posn x y (* len 2/3) angle))

          (define scene1
            (scene+line
             img
             x y
             (posn-x p2) (posn-y p2)
             "orange"))         
          )
    (cond
      [(<= len MIN-LENGTH) scene1]
      [else (local (
                    (define scene2
                      (add-savannah scene1
                                    (posn-x p3)
                                    (posn-y p3)
                                    (* len 8/10)
                                    (- angle 10)))

                    (define scene3
                      (add-savannah scene2
                                    (posn-x p4)
                                    (posn-y p4)
                                    (* len 7/10)
                                    (+ angle 20)))
                    )
            scene3)])
    ))


(add-savannah MT 200 400 100 90)