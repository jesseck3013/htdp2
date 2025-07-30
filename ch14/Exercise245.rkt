;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |14.1|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; function function -? Boolean
(check-expect (function=at-1.2-3-and-5.775?
               sin sin) #true)
(check-expect (function=at-1.2-3-and-5.775?
               sin cos) #false)
(define (function=at-1.2-3-and-5.775? f1 f2)
  (and
   (equal? (f1 1.2) (f2 1.2))
   (equal? (f1 3) (f2 3))
   (equal? (f1 5.775) (f2 5.775))))

; It is impossible to define function=? because there are infinite amount of nubmers.
