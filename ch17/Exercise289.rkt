;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise265) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; String [List-of String] -> Boolean
(check-expect (find-name "Bob"
                         (list "Jack" "Henry" "Bob")) #true)
(check-expect (find-name "Zed"
                         (list "Jack" "Henry" "Bob")) #false)
(define (find-name name lon)
    (ormap (lambda (item) (string=? name item)) lon))

; [List-of String] -> Boolean
(check-expect (all-start-with-a (list "apple"
                                      "andy")) #true)
(check-expect (all-start-with-a (list "yellow"
                                      "andy")) #false)
(define (all-start-with-a lon)
    (andmap (lambda (item)
              (string=? "a" (string-ith item 0))) lon))

; andmap can ensure all names do not exceed a given width
