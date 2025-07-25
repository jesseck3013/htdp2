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
  (cond
    [(empty? dict) '()]
    [else
      (increment-count
       (string-ith (first dict) 0)
       (count-by-letter (rest dict)))]))

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


(count-by-letter AS-LIST)

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
