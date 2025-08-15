;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise220) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define WIDTH 10) ; # of blocks, horizontally 
(define SIZE 10) ; blocks are squares
(define SCENE-SIZE (* WIDTH SIZE))


(define BLOCK ; red squares with black rims
  (overlay
   (square (- SIZE 1) "solid" "red")
   (square SIZE "outline" "black")))

(define-struct tetris [block landscape])
(define-struct block [x y])
 
; A Tetris is a structure:
;   (make-tetris Block Landscape)
; A Landscape is one of: 
; – '() 
; – (cons Block Landscape)
; A Block is a structure:
;   (make-block N N)
 
; interpretations
; (make-block x y) depicts a block whose left 
; corner is (* x SIZE) pixels from the left and
; (* y SIZE) pixels from the top;
; (make-tetris b0 (list b1 b2 ...)) means b0 is the
; dropping block, while b1, b2, and ... are resting

; Block Image -> Image
; Place a Block on the given image
(define (render-block b img)
  (place-image BLOCK
               (* (block-x b) SIZE)
               (* (block-y b) SIZE)
               img))

(define BG (empty-scene SCENE-SIZE SCENE-SIZE))
(check-expect (render-block (make-block 1 1) BG)
              (place-image BLOCK 10 10 BG))

; Landscape -> Image
(define (render-landscape l)
  (cond
    [(empty? l) BG]
    [else (render-block (first l)
                        (render-landscape (rest l)))]))

(check-expect (render-landscape '()) BG)
(check-expect (render-landscape (list (make-block 1 1)))
              (place-image BLOCK 10 10 BG))

; Tetris -> Image
(define (tetris-render s)
  (render-block (tetris-block s)
                (render-landscape (tetris-landscape s))))
(check-expect (tetris-render (make-tetris (make-block 1 1) '()))
              (place-image BLOCK 10 10 BG))
