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

; 1String -> String
; converts the given 1String to a 3-letter numeric String
 
(check-expect (encode-letter "z") (code1 "z"))
(check-expect (encode-letter "\t")
              (string-append "00" (code1 "\t")))
(check-expect (encode-letter "a")
              (string-append "0" (code1 "a")))
 
(define (encode-letter s)
  (cond
    [(>= (string->int s) 100) (code1 s)]
    [(< (string->int s) 10)
     (string-append "00" (code1 s))]
    [(< (string->int s) 100)
     (string-append "0" (code1 s))]))
 
; 1String -> String
; converts the given 1String into a String
 
(check-expect (code1 "z") "122")
 
(define (code1 c)
  (number->string (string->int c)))

; List-of-list-of-strings -> List-of-list-of-strings
(check-expect (encode (cons (cons "abc" '()) '()))
              (cons (cons "097098099" '()) '()))
(check-expect (encode
               (cons
                (cons "hello" (cons "world" '()))
                (cons (cons "abc" '()) '())))
              (cons
               (cons "104101108108111" (cons "119111114108100" '()))
               (cons (cons "097098099" '()) '())))

(define (encode ln)
  (cond
    [(empty? ln) '()]
    [else
     (cons
      (encode-line (first ln))
      (encode (rest ln)))]))

; List-of-String -> List-of-String
(check-expect (encode-line '()) '())
(check-expect (encode-line (cons "abc" '()))
              (cons "097098099" '()))
(define (encode-line l)
  (cond
    [(empty? l) '()]
    [else (cons (encode-word (first l))
                (encode-line (rest l)))]))

; String -> String
(check-expect (encode-word "abc") "097098099")
(define (encode-word w)
  (merge
   (encode-list-of-letter (explode w))))

; List-of-letters -> List-of-String
(check-expect (encode-list-of-letter (explode "abc"))
              (cons "097" (cons "098" (cons "099" '()))))
(define (encode-list-of-letter lot)
  (cond
    [(empty? lot) '()]
    [else (cons (encode-letter (first lot))
                (encode-list-of-letter (rest lot)))]))

; list-of-string -> String
(check-expect (merge '()) "")
(check-expect (merge (cons "hello" (cons "world" '())))
              "helloworld")
(define (merge los)
  (cond
    [(empty? los) ""]
    [else (string-append (first los)
                         (merge (rest los)))]))

(define (main n)
  (write-file (string-append "encoded-" n)
              (collapse 
               (encode (read-words/line n)))))

(main "ttt.dat")
