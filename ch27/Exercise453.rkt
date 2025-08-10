;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |27.1|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; A Line is a [List-of 1String].

; A token is one of:
; - 1String
; - String with consecutive letters

; Line -> [List-of tokens]
(check-expect (tokenize '("a" " " "b" "c" "d")) '("a" "b" "c" "d"))
(check-expect (tokenize '("a" " " "b" " " "b" " " "c" "d")) '("a" "bb" "c" "d"))
(check-expect (tokenize '("a" " " "b" " " "b" " " "c" "c" "d")) '("a" "bb" "cc" "d"))
(check-expect (tokenize '(" ")) '())
(define (tokenize line)
  (cond
    [(empty? line) '()]
    [(string-whitespace? (first line)) (tokenize (rest line))]
    [else (cons (first-token line)
                (tokenize (rest-token line)))]))

; Line -> token
(check-expect (first-token
               (list "a" "b" "c")) "a")
(check-expect (first-token
               (list "a" "a" "c")) "aa")
(check-expect (first-token
               (list "a" " " "a" " " "c")) "aa")

(define (first-token line)
  (cond
    [(empty? line) '()]
    [(string-whitespace? (first line))
     (first-token (rest line))]
    [else
     (string-append (first line)
                    (read-concecutive-string (first line)
                                             (rest line)))]))
; Line 1String -> token
(check-expect (read-concecutive-string "a" (list "a" "b" "c")) "a")
(define (read-concecutive-string char line)
  (cond
    [(empty? line) ""]
    [(string-whitespace? (first line)) (read-concecutive-string char (rest line))]
    [(string=? (first line) char)
     (string-append char
                    (read-concecutive-string
                     char
                     (rest line)))]
    [else ""]))

; Line -> Line
; remove the first token
(check-expect (rest-token '()) '())
(check-expect (rest-token '("a" "b" "c")) '("b" "c"))
(check-expect (rest-token '("a" " " "b" "c")) '("b" "c"))
(check-expect (rest-token '("a" " " "a" "a" " " "b" "c")) '("b" "c"))

(define (rest-token line)
  (cond
    [(empty? line) '()]
    [(string-whitespace? (first line))
     (rest-token (rest line))]
    [else (remove-consecutive-string (first line) (rest line))]))


; 1String Line -> Line
(define (remove-consecutive-string char line)
  (cond
    [(empty? line) '()]
    [(string-whitespace? (first line)) (remove-consecutive-string char (rest line))]
    [(string=? (first line) char)
     (remove-consecutive-string char (rest line))]
    [else line]))
