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

; List-of-List-of-String -> List-of-List-of-String
(check-expect (remove-articles
               (cons
                (cons "hello" (cons "an" '()))
                (cons 
                 (cons "the" (cons "hello" '())) '())))
              (cons
               (cons "hello" '())
               (cons 
                (cons "hello" '())
                '())))

(define (remove-articles ln)
  (cond
    [(empty? ln) '()]
    [else (cons
           (remove-articles-line (first ln))
           (remove-articles (rest ln)))]))

; List-of-strings -> List-of-strings
(check-expect (remove-articles-line '()) '())
(check-expect (remove-articles-line
               (cons "the" '())) '())
(check-expect (remove-articles-line
               (cons "test" '()))
              (cons "test" '()))
(define (remove-articles-line l)
  (cond
    [(empty? l) '()]
    [else
     (if (is-article (first l))
         (remove-articles-line (rest l))
         (cons (first l)
               (remove-articles-line (rest l))))]))

; String -> Boolean
(check-expect (is-article "the") #true)
(check-expect (is-article "an") #true)
(check-expect (is-article "a") #true)
(check-expect (is-article "test") #false)
(define (is-article s)
  (or (string=? s "the")
      (string=? s "an")
      (string=? s "a")))

(define (main n)
  (write-file (string-append "no-articles-" n)
              (collapse 
               (remove-articles (read-words/line n)))))

(main "ttt.txt")
