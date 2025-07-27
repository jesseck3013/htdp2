;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |12.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))

; List-of-strings -> Boolean
(define (all-words-from-rat? w)
  (and
    (member? "rat" w) (member? "art" w) (member? "tar" w)))
 
; String -> List-of-strings
; finds all words that the letters of some given word spell
 
(check-member-of (alternative-words "cat")
                 (list "act" "cat")
                 (list "cat" "act"))
 
(check-satisfied (alternative-words "rat")
                 all-words-from-rat?)
 
(define (alternative-words s)
  (in-dictionary
    (words->strings (arrangements (string->word s)))))
 
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

(define LOCATION "/usr/share/dict/words")
 
; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))

; List-of-strings -> List-of-strings
; picks out all those Strings that occur in the dictionary
(check-expect (in-dictionary '()) '())
(check-expect (in-dictionary (list "apple" "elppa"))
             (list "apple"))

(define (in-dictionary los)
  (cond
    [(empty? los) '()]
    [(member? (first los) AS-LIST)
     (cons (first los) (in-dictionary (rest los)))]
    [else (in-dictionary (rest los))]))


;; (check-expect (arrangements (list "d" "e"))
;;               (list
;;                (list "d" "e")
;;                (list "e" "d")))
; Word -> List-of-words
; finds all rearrangements of word
(define (arrangements w)
  (cond
    [(empty? w) (list '())]
    [else
     (insert-everywhere/in-all-words
      (first w) (arrangements (rest w)))]))

; 1String List-of-words -> List-of-words
(check-expect (insert-everywhere/in-all-words
               "e" '())
              '())
(check-expect (insert-everywhere/in-all-words
               "e" (list '()))
              (list
               (list "e")))
(check-expect (insert-everywhere/in-all-words
               "r"
               (list
                (list "e")))
              (list
               (list "r" "e")
               (list "e" "r")))

(define (corret-insert-result r)
  (and
   (member? (list "d" "e" "r") r)
   (member? (list "e" "d" "r") r)
   (member? (list "e" "r" "d") r)
   (member? (list "d" "r" "e") r)
   (member? (list "r" "d" "e") r)
   (member? (list "r" "e" "d") r)))
  
(check-satisfied (insert-everywhere/in-all-words
               "d"
               (list
                (list "e" "r")
                (list "r" "e")))
                 corret-insert-result)

(define (insert-everywhere/in-all-words s low)
  (cond
    [(empty? low) '()]
    [else
     (append 
      (insert-everywhere s (first low))
      (insert-everywhere/in-all-words s (rest low)))]))

; 1String Wrod -> List-of-words
(check-expect (insert-everywhere "o" '())
              (list
               (list "o")))
(check-expect (insert-everywhere "k" (list "o"))
              (list
               (list "k" "o")
               (list "o" "k")))
(define (insert-everywhere s w)
  (cond
    [(empty? w) (list (list s))]
    [else
     (cons
      (cons s w)
      (add-to-all-first
       (first w)
       (insert-everywhere s (rest w))))]))

; 1String List-of-Word -> List-of-Word
(check-expect (add-to-all-first "k" (list
                                     (list "a" "b")
                                     (list "b" "a")))
              (list
               (list "k" "a" "b")
               (list "k" "b" "a")))
(define (add-to-all-first k l)
  (cond
    [(empty? l) '()]
    [else
     (cons (cons k (first l))
           (add-to-all-first k (rest l)))]))
  
; List-of-words -> List-of-strings
(check-expect (words->strings '()) '())
(check-expect (words->strings
               (list 
                (list "h" "e" "l" "l" "o")
                (list "w" "o" "r" "l" "d")))
              (list "hello" "world"))

(define (words->strings low)
  (cond
    [(empty? low) '()]
    [else
     (cons (word->string (first low))
           (words->strings (rest low)))]))
