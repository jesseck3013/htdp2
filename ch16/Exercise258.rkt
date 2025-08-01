;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise246) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; Image Background
(define MT (empty-scene 50 50))
(define square-p
  (list
   (make-posn 10 10)
   (make-posn 20 10)
   (make-posn 20 20)
   (make-posn 10 20)))

(define triangle-p
  (list
   (make-posn 20 10)
   (make-posn 20 20)
   (make-posn 30 20)))

; Image Polygon -> Image 
; adds an image of p to MT
(define (render-poly img p)
  (local 
      (
       ; Image Posn Posn -> Image 
       ; draws a red line from Posn p to Posn q into im
       (define (render-line im p q)
         (scene+line
          im (posn-x p)
          (posn-y p)
          (posn-x q)
          (posn-y q) "red"))

       ; Image NELoP -> Image
       ; connects the Posns in p in an image
       (define (connect-dots img p)
         (cond
           [(empty? (rest p)) MT]
           [else (render-line (connect-dots img (rest p))
                              (first p)
                              (second p))]))
       ; Polygon -> Posn
       ; extracts the last item from p
       (define (last p)
         (cond
           [(empty? (rest (rest (rest p)))) (third p)]
           [else (last (rest p))]))
       )    
  (render-line (connect-dots img p) (first p) (last p))))

(render-poly MT triangle-p)
(render-poly MT square-p)
