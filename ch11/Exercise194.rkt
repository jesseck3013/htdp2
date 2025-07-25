;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |11|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

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

; A Polygon is one of:
; – (list Posn Posn Posn)
; – (cons Posn Polygon)

; a plain background image 
(define MT (empty-scene 50 50))

; Image Posn Posn -> Image 
; draws a red line from Posn p to Posn q into im
(check-expect
 (render-line MT (make-posn 1 1) (make-posn 2 2))
 (scene+line MT 1 1 2 2 "red"))
(define (render-line img p q)
  (scene+line
   img
   (posn-x p) (posn-y p)
   (posn-x q) (posn-y q)
  "red"))

; NELoP -> Posn
; extracts the last item from p
(define posn-1 (make-posn 1 1))
(define posn-2 (make-posn 2 2))
(define posn-3 (make-posn 3 3))
(define posn-4 (make-posn 4 4))
(check-expect
 (last (list posn-1 posn-2 posn-3 posn-4)) posn-4)
(check-expect (last (list posn-1)) posn-1)
(define (last p)
  (cond
    [(empty? (rest p)) (first p)]
    [else (last (rest p))]))

(check-expect
 (render-poly MT triangle-p)
 (scene+line
  (scene+line
   (scene+line MT 20 10 20 20 "red")
   20 20 30 20 "red")
  30 20 20 10 "red"))

(check-expect
 (render-poly MT square-p)
 (scene+line
  (scene+line
   (scene+line
    (scene+line MT 10 10 20 10 "red")
    20 10 20 20 "red")
   20 20 10 20 "red")
  10 20 10 10 "red"))

; An NELoP is one of: 
; – (cons Posn '())
; – (cons Posn NELoP)

; Image NELoP Posn -> Image 
; connects the dots in p by rendering lines in img
(define (connect-dots img p lp)
  (cond
    [(empty? (rest p)) (render-line img (first p) lp)]
    [else
     (render-line
      (connect-dots img (rest p) lp)
      (first p) (second p))]))

(check-expect (connect-dots MT triangle-p (first triangle-p))
              (scene+line
               (scene+line
                (scene+line MT 20 20 30 20 "red")
                20 10 20 20 "red")
               30 20 20 10 "red"))

(check-expect (connect-dots MT square-p (first square-p))
              (scene+line
               (scene+line 
                (scene+line
                 (scene+line MT 10 10 20 10 "red")
                 20 10 20 20 "red")
                20 20 10 20 "red")
               10 20 10 10 "red"))


; Image Polygon -> Image
; renders the given polygon p into img
(define (render-poly img p)
  (connect-dots img p (first p)))


