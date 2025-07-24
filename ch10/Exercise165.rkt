;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise153) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; List-of-toy is one of
; '()
; (cons String List-of-toy)

; List-of-toy -> List-of-toy
(check-expect (subst-robot '()) '())
(check-expect (subst-robot (cons "robot" '())) (cons "r2d2" '()))
(check-expect (subst-robot (cons "test" '())) (cons "test" '()))
(check-expect (subst-robot (cons "robot" (cons "robot" '()))) (cons "r2d2" (cons "r2d2" '())))
(define (subst-robot lot)
  (cond
    [(empty? lot) '()]
    [else (if (string=? (first lot) "robot")
              (cons "r2d2" (subst-robot (rest lot)))
              (cons (first lot) (subst-robot (rest lot))))]))


; List-of-strings -> List-of-strings
(check-expect (substitute '() "robot" "r2d2") '())
(check-expect (substitute (cons "robot" '())
                          "robot"
                          "r2d2")
              (cons "r2d2" '()))
(check-expect (substitute (cons "test" '())
                          "robot"
                          "r2d2")
              (cons "test" '()))
(check-expect (substitute
               (cons "robot" (cons "robot" '()))
               "robot"
               "r2d2")
              (cons "r2d2" (cons "r2d2" '())))
(define (substitute los old new)
  (cond
    [(empty? los) '()]
    [else (if (string=? (first los) old)
              (cons new (substitute (rest los) old new))
              (cons (first los)
                    (substitute (rest los) old new)))]))
