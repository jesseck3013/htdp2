;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |12.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))

; A Word is one of:
; – '() or
; – (cons 1String Word)
; interpretation a Word is a list of 1Strings (letters)

; Word Examples:
'()
(list "h")
(list "l" "i" "s" "p")

; List-of-words is one of:
; - '()
; - (cons Word List-of-words)

; List-of-words examples:
'()
(list
 (list "l" "i" "s" "p")
 (list "r" "a" "k" "e" "t"))


(check-expect (arrangements (list "d" "e"))
              (list "d" "e")
              (list "e" "d"))
; Word -> List-of-words
; finds all rearrangements of word
(define (arrangements word)
  (list word))

