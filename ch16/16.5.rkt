;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise265) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; [List-of Posn] -> [List-of Posn]
; adds 3 to each x-coordinate on the given list 
 
(check-expect
 (add-3-to-all
   (list (make-posn 3 1) (make-posn 0 0)))
 (list (make-posn 6 1) (make-posn 3 0)))
 
(define (add-3-to-all lop)
  (local (; Posn -> Posn
          ; adds 3 to the x-coordinate of p
          (define (add-3-to-1 p)
            (make-posn (+ (posn-x p) 3) (posn-y p))))
    (map add-3-to-1 lop)))


; Posn Posn -> Number
(check-expect (distance (make-posn 0 0)
                        (make-posn 3 4)) 5)
(define (distance p q)
  (sqrt (+ (sqr (- (posn-x p)
                      (posn-x q)))
              (sqr (- (posn-y p)
                      (posn-y q))))))

; Posn Posn Number -> Boolean
; is the distance between p and q less than d
(define (close-to p q d)
  (<= (distance p q) d))

; [List-of Posn] Posn -> Boolean
; is any Posn on lop close to pt
(check-expect
 (close? (list (make-posn 47 54) (make-posn 0 60))
         (make-posn 50 50))
 #true)
 
(define (close? lop pt)
  (local (; Posn -> Boolean
          ; is one shot close to pt
          (define (is-one-close? p)
            (close-to p pt CLOSENESS)))
    (ormap is-one-close? lop)))

(define CLOSENESS 5) ; in terms of pixels 

