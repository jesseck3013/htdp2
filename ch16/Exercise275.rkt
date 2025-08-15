;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise265) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

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

; Letter-Counts is a structure
; (make-struct 1String Number)
; (make-struct L C) means the letter L's frequency is C.
(define-struct LC [letter count])

; Dictionary -> List-of-letter-counts
(check-expect (count-by-letter (list "apple"))
              (list (make-LC "a" 1)))

(check-member-of (count-by-letter (list "apple" "yellow"))
                  (list (make-LC "a" 1)
                        (make-LC "y" 1))
                  (list (make-LC "y" 1)
                        (make-LC "a" 1)))

(check-expect (count-by-letter '()) '())

(define (count-by-letter dict)
  (foldr (lambda (word rst)
           (increment-count (string-ith word 0)
                            rst))
         '() dict))

; 1String List-of-letter-counts -> List-of-letter-counts
(check-expect (increment-count "a" '())
              (list (make-LC "a" 1)))

(check-expect (increment-count "a" (list (make-LC "a" 1)))
              (list (make-LC "a" 2)))
(define (increment-count letter llc)
  (if (member? letter LETTERS)
      (cond
        [(empty? llc) (list (make-LC letter 1))]
        [(string=? letter (LC-letter (first llc)))
         (cons (make-LC letter
                        (+ 1 (LC-count (first llc))))
               (rest llc))]
        [else
         (cons (first llc)
               (increment-count letter (rest llc)))])
      llc))

;(count-by-letter AS-LIST)
; Output:
;; (#(struct:LC "z" 190)
;;  #(struct:LC "y" 314)
;;  #(struct:LC "x" 68)
;;  #(struct:LC "w" 2827)
;;  #(struct:LC "v" 1553)
;;  #(struct:LC "u" 2470)
;;  #(struct:LC "t" 5339)
;;  #(struct:LC "s" 11879)
;;  #(struct:LC "r" 6060)
;;  #(struct:LC "q" 502)
;;  #(struct:LC "p" 8288)
;;  #(struct:LC "o" 2506)
;;  #(struct:LC "n" 2160)
;;  #(struct:LC "m" 5467)
;;  #(struct:LC "l" 3122)
;;  #(struct:LC "k" 782)
;;  #(struct:LC "j" 923)
;;  #(struct:LC "i" 4055)
;;  #(struct:LC "h" 3806)
;;  #(struct:LC "g" 3384)
;;  #(struct:LC "f" 4448)
;;  #(struct:LC "e" 4028)
;;  #(struct:LC "d" 6352)
;;  #(struct:LC "c" 10114)
;;  #(struct:LC "b" 6131)
;;  #(struct:LC "a" 5632))

; Dictionary -> LC
(check-expect (most-frequent
               (list "apple" "april" "yellow"))
              (make-LC "a" 2))
(define (most-frequent dict)
  (pick-max-count (count-by-letter dict)))

; List-of-LC -> LC
; Output the LC with the highest count
(check-expect (pick-max-count
               (list (make-LC "a" 10)
                     (make-LC "b" 20)
                     (make-LC "c" 30)))
              (make-LC "c" 30))
(define (pick-max-count lc)
  (foldr (lambda (item rst)
           (if
            (> (LC-count item)
               (LC-count rst))
            item
            rst)) (make-LC "dummy" -1) lc))
  ;; (cond
  ;;   [(empty? (rest lc)) (first lc)]
  ;;   [else
  ;;    (if
      
  ;;     (first lc)
  ;;     (pick-max-count (rest lc)))]))

; Dictionary -> List-of-Dictionaries
; Produce a list of Dictionaries, one per Letter
(check-expect (words-by-first-letter '()) '())
(check-member-of (words-by-first-letter
               (list "apple"
                     "and"
                     "banana"))
              (list (list "banana")
                    (list "apple" "and"))
              (list
               (list "apple" "and")
               (list "banana")))

(define (words-by-first-letter dict)
  (foldr
   (lambda (item rst)
     (if (empty? item)
         rst
         (cons item rst)))
   '()
   (map (lambda (letter)
          (foldr (lambda (word rst)
                   (if (equal? (first (explode word)) letter)
                       (cons word rst)
                       rst)) '() dict)) LETTERS)))

; String List-of-Dictionaries -> List-of-Dictionaries
; insert a word into a list of dictionaries which are grouped by the first letter.
(check-expect (insert-word "apple" '()) (list (list "apple")))
(check-expect (insert-word
               "apple"
               (list 
                (list "and" "ant")
                (list "banana")))
              (list
               (list "apple" "and" "ant")
               (list "banana")))
(define (insert-word word lod)
  (cond
    [(empty? lod) (list (list word))]
    [(same-first-letter word (first lod))
     (cons
      (cons word (first lod))
      (rest lod))]
    [else 
     (cons (first lod)
           (insert-word word (rest lod)))]))

; String Dictionary -> Boolean
; dict is a Dictionary with only the same first letter.
; this function checks if word's first letter is the same as all the words in the dict.
(check-expect
 (same-first-letter "apple" (list "ant")) #true)
(check-expect
 (same-first-letter "apple" (list "bad")) #false)

(define (same-first-letter word dict)
  (string=? (string-ith word 0)
            (string-ith (first dict) 0)))

; List-of-Dictionaries -> LC
(check-expect (most-frequent.v3
               (list (list "apple" "ant")
                     (list "banana")))
              (make-LC "a" 2))

; List-of-Dictionaries -> LC
(define (most-frequent.v3 lod)
  (pick-max-count (count-length lod)))

; Dictionary -> 1String
(check-expect (get-first-letter (list "apple")) "a")
(define (get-first-letter dict)
  (first (explode (first dict))))

; List-of-Dictionary -> List-of-LC
(check-expect (count-length (list (list "apple" "ant")
                                  (list "banana")))
              (list (make-LC "a" 2)
                    (make-LC "b" 1)))
(define (count-length lod)
  (cond
    [(empty? lod) '()]
    [else (cons (make-LC (get-first-letter (first lod)) (length (first lod)))
                (count-length (rest lod)))]))

; (define LIST-OF-DICTIONAIES (words-by-first-letter AS-LIST))
;; (check-expect (most-frequent AS-LIST)
;;               (most-frequent.v3 LIST-OF-DICTIONAIES))
