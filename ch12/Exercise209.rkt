;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |12.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))

; A Word is one of:
; – '() or
; – (cons 1String Word)
; interpretation a Word is a list of 1Strings (letters)

; String -> Word
; converts s to the chosen word representation
(check-expect (string->word "") '())
(check-expect (string->word "hello")
              (list "h" "e" "l" "l" "o"))
(define (string->word s)
  (cond
    [(= (string-length s) 0) '()]
    [else
     (cons
      (string-ith s 0)
      (string->word (substring s 1 (string-length s))))]))

 
; Word -> String
; converts w to a string
(check-expect (word->string '()) "")
(check-expect
 (word->string (list "h" "e" "l" "l" "o")) "hello")
(define (word->string w)
  (cond
    [(empty? w) ""]
    [else (string-append (first w)
                         (word->string (rest w)))]))
     
