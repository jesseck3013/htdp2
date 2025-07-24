;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise153) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; List-of-list-of-strings is one of:
; - '()
; - (cons List-of-strings List-of-list-of-string)

; file-info is a structure:
; (file-info Number Number Number)
; (file-info na le wo li) represents a file that has
; - na as its file name
; - le 1Strings
; - wo words
; - li lines
(define-struct file-info [name letter word line])

; file-info -> String
(check-expect (print (make-file-info "test.txt" 100 20 3))
              "The file test.txt has 100 1Strings, 20 words, 3 lines.")
(define (print fi)
  (string-append
   "The file "
   (file-info-name fi)
   " has "
   (number->string (file-info-letter fi))
   " 1Strings, "
   (number->string (file-info-word fi))
   " words, "
   (number->string (file-info-line fi))
   " lines."))

; List-of-String -> Number
(check-expect (count-line-letters '()) 0)
(check-expect (count-line-letters
               (cons "hello" (cons "world" '()))) 10)
(define (count-line-letters ll)
  (cond
    [(empty? ll) 0]
    [else (+ (length (explode (first ll)))
             (count-line-letters (rest ll)))]))

; List-of-list-of-strings -> Number
(check-expect (count-letters '()) 0)
(check-expect (count-letters
               (cons
                (cons "hello" (cons "world" '()))
                (cons 
                 (cons "world" (cons "hello" '())) '())))
              20)
(define (count-letters ln)
  (cond
    [(empty? ln) 0]
    [else (+ (count-line-letters (first ln))
             (count-letters (rest ln)))]))

; List-of-list-of-strings -> Number
(check-expect (count-words '()) 0)
(check-expect (count-words
               (cons
                (cons "hello" (cons "world" '()))
                (cons 
                 (cons "world" (cons "hello" '())) '())))
              4)
(define (count-words ln)
  (cond
    [(empty? ln) 0]
    [else (+ (length (first ln))
             (count-words (rest ln)))]))

; List-of-list-of-strings -> Number
(check-expect (count-lines '()) 0)
(check-expect (count-lines
               (cons
                (cons "hello" (cons "world" '()))
                (cons 
                 (cons "world" (cons "hello" '())) '()))) 2)
(define (count-lines ln)
  (length ln))

; List-of-list-of-strings -> file-info
(check-expect (wc "test.txt"
                  '())
                  (make-file-info "test.txt"
                                  0
                                  0
                                  0))
(check-expect (wc "test.txt"
                  (cons
                   (cons "hello" (cons "world" '()))
                   (cons 
                    (cons "world" (cons "hello" '())) '())))
                  (make-file-info "test.txt"
                                  20
                                  4
                                  2))
(define (wc name ln)
  (make-file-info name
                  (count-letters ln)
                  (count-words ln)
                  (count-lines ln)))

(define (main n)
  (print (wc n (read-words/line n))))

(main "ttt.dat")
