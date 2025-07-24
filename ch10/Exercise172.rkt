;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise153) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; List-of-list-of-strings is one of:
; - '()
; - (cons List-of-strings List-of-list-of-string)


; LN -> String
; convert a list of lines into a string
(check-expect (collapse
               (cons
                (cons "hello" (cons "world" '()))
                (cons 
                 (cons "world" (cons "hello" '())) '())))
              "hello world\nworld hello")

(define (collapse ln)
  (cond
    [(empty? ln) ""]
    [else
     (string-append
      (line-processor (first ln))
      (if (empty? (rest ln))
          ""
          "\n")
      (collapse (rest ln)))]))

; List-of-string -> String
; put all string item into one string
(define (line-processor l)
  (cond
    [(empty? l) ""]
    [else (string-append
           (first l)
           (if (empty? (rest l))
               ""
               " ")
           (line-processor (rest l)))]))

(write-file "ttt.dat"
            (collapse (read-words/line "ttt.txt")))
