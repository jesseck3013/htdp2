;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname data_info) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(- 200 (cond [(> y 200) 0] [else y]))
;; stepper output:
;; when y is 100
;; (- 200 (cond [(> y 200) 0] [else y]))
;; (- 200 (cond [(> 100 200) 0] [else 100]))
;; (- 200 (cond [#false 0] [else 100]))
;; (- 200 (cond [else 100]))
;; (- 200 100)
;; 100

;; when y is 210
;; (- 200 (cond [(> 210 200) 0] [else 210]))
;; (- 200 (cond [#true 0] [else 210]))
;; (- 200 0)
;; 200



(define ROCKET-CENTER-TO-TOP
  (- HEIGHT (/ (image-height ROCKET) 2)))
 
(define (create-rocket-scene.v5 h)
  (place-image ROCKET 50
               (cond
                 [(<= h ROCKET-CENTER-TO-TOP) h]
                 [else ROCKET-CENTER-TO-TOP])
               MTSCN))
