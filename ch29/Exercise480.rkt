;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise480) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define MT (empty-scene 0 0))
(define QUEEN-SOURCE (bitmap "../resources/chess-queen.jpg"))
(define QUEEN (scale 0.2 QUEEN-SOURCE))
(define EMPTY-SQUARE (rectangle 100 100 "outline" "black"))
(define QUEEN-SQUARE (overlay QUEEN EMPTY-SQUARE))

; N [List-of QP] Image -> Image
(define (render-queens n lo-qp img)
  (local (
          (define board
            (build-list n (lambda (row)
                            (build-list n (lambda (col)
                                                   (list row col))))))

          (define (render board)
            (foldr (lambda (row rst)
                     (above (render-row row)
                            rst)) img board))

          (define (render-row row)
            (foldr (lambda (sq rst)
                     (if (member? (make-posn (first sq)
                                            (second sq))
                                 lo-qp)
                         (beside QUEEN-SQUARE rst)
                         (beside EMPTY-SQUARE rst))) img row))

          )
    (render board)))

(render-queens 4 (list (make-posn 0 1)
                       (make-posn 1 3)
                       (make-posn 2 0)
                       (make-posn 3 2)) MT)




