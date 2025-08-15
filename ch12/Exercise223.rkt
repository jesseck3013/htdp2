;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise221) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define WIDTH 10) ; # of blocks, horizontally 
(define SIZE 10) ; blocks are squares
(define SCENE-SIZE (* WIDTH SIZE))

(define MIN-X 0.5)
(define MAX-X 9.5)
(define MIN-Y 0.5)
(define MAX-Y 9.5)
(define MID-X 5)
(define SPEED 0.5)

(define BLOCK ; red squares with black rims
  (overlay
   (square (- SIZE 1) "solid" "red")
   (square SIZE "outline" "black")))

(define-struct tetris [block landscape])
(define-struct block [x y])

(define BLOCK0 (make-block MID-X MIN-Y))
 
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

; Block Landscape -> Boolean
(define (land? b l)
  (cond
    [(>= (block-y b) MAX-Y) #true]
    [(empty? l) #false]
    [else (or
           (and 
            (= (block-x b)
               (block-x (first l)))
            (<= (abs
                 (- (block-y b)
                   (block-y (first l))))
                1))
           (land? b (rest l)))]))
(check-expect (land? (make-block 5 8.5) (list (make-block 5 9.5)))
              #true)
(check-expect (land? (make-block 5 8.5) (list
                                         (make-block 4 9.5)
                                         (make-block 3 9.5)))
              #false)
(check-expect (land? (make-block 5 9.5) (list
                                         (make-block 4 9.5)
                                         (make-block 3 9.5)))
              #true)

; Tetris -> Tetris
(define (tock t)
  (cond
    [(land? (tetris-block t)
            (tetris-landscape t))
     (make-tetris 
      (block-generate MIN-Y)
      (cons (tetris-block t)
            (tetris-landscape t)))]
    [else (make-tetris
           (make-block (block-x (tetris-block t))
                       (+ (block-y (tetris-block t)) SPEED))
           (tetris-landscape t))]))

(define BLOCK1 (make-block MID-X 9.5))
(define t0 (make-tetris BLOCK0 '()))
(define t1 (make-tetris BLOCK1 '()))
(check-expect (tock t0) (make-tetris (make-block MID-X 1) '()))
(check-random
 (tock t1)
 (make-tetris (make-block (+ 0.5 (random (sub1 SIZE))) MIN-Y) (list BLOCK1)))

(define (block-generate y)
  (make-block (+ 0.5 (random (sub1 SIZE))) y))

; Block [List-of Block] String -> Boolean
(define (possible b l direction)
  (cond
    [(string=? direction "left")     
     (cond
       [(<= (block-x b) MIN-X) #false]
       [(empty? l) #true]
       [else (or
              (and
              (= (block-y b) (block-y (first l)))
              (<= 0 (- (block-x b) (block-y (first l))) SPEED))
              (possible b (rest l) direction))])]
    [(string=? direction "right")
     (cond
       [(>= (block-x b) MAX-X) #false]
       [(empty? l) #true]
       [else (or
              (and
               (= (block-y b) (block-y (first l)))
               (<= 0 (- (block-y (first l)) (block-x b)) SPEED))
              (possible b (rest l) direction))])]))

; Tetris KeyEvent -> Tetris
(define (key-handler t ke)
  (cond
    [(and
      (string=? ke "left")
      (possible (tetris-block t)
                (tetris-landscape t)
                ke))
     (make-tetris (make-block (- (block-x (tetris-block t)) SPEED)
                              (block-y (tetris-block t)))
                  (tetris-landscape t))]
    [(and (string=? ke "right")
          (possible (tetris-block t)
                    (tetris-landscape t)
                    ke))
     (make-tetris (make-block (+ SPEED (block-x (tetris-block t)))
                              (block-y (tetris-block t)))
                  (tetris-landscape t))]
    [else t]))

(check-expect (key-handler t0 "left")
              (make-tetris (make-block (- MID-X 0.5) 0.5) '()))

(check-expect (key-handler t0 "right")
              (make-tetris (make-block (+ MID-X 0.5) 0.5) '()))

; Tetris -> Boolean
(define (game-over? t)
  (cond
    [(empty? (tetris-landscape t)) #false]
    [(= (block-y (first (tetris-landscape t))) MIN-Y) #true]
    [else (game-over? (make-tetris (tetris-block t)
                                   (rest (tetris-landscape t))))]))

; Tetris -> Image
(define (game-over-scene t)
  (text (string-append
         "Game Over"
         "\n"
         "Score: "
         (number->string (length (tetris-landscape t))))
         16 "black"))

(check-expect (game-over? (make-tetris BLOCK0 (list BLOCK0))) #true)

(define (tetris-main t0)
  (big-bang t0
    [to-draw tetris-render]
    [on-tick tock]
    [on-key key-handler]
    [stop-when game-over? game-over-scene]))

(tetris-main t0)
