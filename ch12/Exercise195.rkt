;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |11|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define LOCATION "/usr/share/dict/words")
 
; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))

; A Letter is one of the following 1Strings: 
; – "a"
; – ... 
; – "z"
; or, equivalently, a member? of this list: 
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

; Letter Dictionary -> Number
; Compute the number of words in dict that start with letter.
(check-expect (starts-with# "a" '()) 0)
(check-expect (starts-with# "a" (list "apple" "yellw")) 1)
(check-expect (starts-with# "a" (list "cat" "yellw")) 0)

(define (starts-with# letter dict)
  (cond
    [(empty? dict) 0]
    [else (if (starts-with letter (first dict))
              (+ 1 (starts-with# letter (rest dict)))
              (starts-with# letter (rest dict)))]))

; Letter String -> Boolean
; Determine if str starts with letter
(check-expect (starts-with "a" "apple") #true)
(check-expect (starts-with "b" "apple") #false)
(define (starts-with letter str)
  (string=? letter (first (explode str))))

(starts-with# "e" AS-LIST) ; 4028
(starts-with# "z" AS-LIST) ; 190
