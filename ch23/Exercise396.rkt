;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define LOCATION "/usr/share/dict/words")
 
; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))
(define SIZE (length AS-LIST))

; A Letter is one of the following 1Strings: 
; – "a"
; – ... 
; – "z"
; or, equivalently, a member? of this list: 
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

; An HM-Word is a [List-of Letter or "_"]
; interpretation "_" represents a letter to be guessed 
 
; HM-Word N -> String
; runs a simplistic hangman game, produces the current state
(define (play the-pick time-limit)
  (local ((define the-word  (explode the-pick))
          (define the-guess (make-list (length the-word) "_"))
          ; HM-Word -> HM-Word
          (define (do-nothing s) s)
          ; HM-Word KeyEvent -> HM-Word 
          (define (checked-compare current-status ke)
            (if (member? ke LETTERS)
                (compare-word the-word current-status ke)
                current-status)))
    (implode
     (big-bang the-guess ; HM-Word
       [to-draw render-word]
       [on-tick do-nothing 1 time-limit]
       [on-key  checked-compare]))))
 
; HM-Word -> Image
(define (render-word w)
  (text (implode w) 22 "black"))

; HM-Word HM-Word Letter -> HM-Word
(check-expect (compare-word '("h" "e" "l" "l" "o")
                            '("_" "_" "_" "_" "_")
                            "e")
              '("_" "e" "_" "_" "_"))

(check-expect (compare-word '("h" "e" "l" "l" "o")
                            '("_" "_" "_" "_" "_")
                            "w")
              '("_" "_" "_" "_" "_"))

(define (compare-word the-word current-status ke)
  (cond
    [(empty? the-word) '()]
    [(not (string=? (first current-status) "_"))
     (cons (first current-status)
           (compare-word (rest the-word)
                         (rest current-status)
                         ke))]
    [(string=? (first the-word) ke)
     (cons (first the-word) (rest current-status))]
    [else (cons (first current-status)
                (compare-word (rest the-word)
                              (rest current-status)
                              ke))]))

(play (list-ref AS-LIST (random SIZE)) 10)
