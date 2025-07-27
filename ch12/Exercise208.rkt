;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.h
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |12.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))

; List-of-strings -> List-of-strings
; Create a list of string that only contains each album once
(check-expect (create-set
               (list "album1"
                    "album1"
                    "album1"))
              (list "album1"))
(check-expect (create-set '()) '())
(define (create-set los)
  (cond
    [(empty? los) '()]
    [(member?
      (first los) (rest los))
     (create-set (rest los))]
    [else (cons (first los) (create-set (rest los)))]))

; modify the following to use your chosen name
(define ITUNES-LOCATION "itunes.xml")

; LLists
(define list-tracks
  (read-itunes-as-lists ITUNES-LOCATION))

; LAssoc
(define LAssoc1 '())
(define LAssoc2
  (list 
   (list "Track ID" 442)
   (list "Name" "Wild Child")
   (list "Artist" "Enya")
   (list "Album" "A Day Without Rain")
   (list "Genre" "New Age")
   (list "Kind" "MPEG audio file")
   (list "Size" 4562044)
   (list "Total Time" 227996)
   (list "Track Number" 2)
   (list "Track Count" 11)
   (list "Year" 2000)
   (list "Date Modified" #(struct:date 2002 7 17 0 0 11))
   (list "Date Added" #(struct:date 2002 7 17 3 55 14))
   (list "Bit Rate" 160)
   (list "Sample Rate" 44100)
   (list "Play Count" 20)
   (list "Play Date" 3388484113)
   (list "Play Date UTC" #(struct:date 2011 5 17 17 35 13))
   (list "Sort Album" "Day Without Rain")
   (list "Persistent ID" "EBBE9171392FA348")
   (list "Track Type" "File")
   (list "Location"
    "file://localhost/Users/matthias/Music/iTunes/iTunes%20Music/Enya/A%20Day%20Without%20Rain/02%20Wild%20Child.mp3")
   (list "File Folder Count" 4)
   (list "Library Folder Count" 1)
   (list "my-boolean" #false)))
; LLists
(define LLists1 '())
(define LLists2 (cons LAssoc2 '()))

; String LAssoc Any -> Association

(check-expect (find-association
               "Track ID" LAssoc1 "default")
               "default")

(check-expect (find-association
               "Track ID" LAssoc2 "default")
               (list "Track ID" 442))

(check-expect (find-association
               "inexisting key" LAssoc2 "default")
               "default")

(define (find-association key lassoc default)
  (cond
    [(empty? lassoc) default]
    [(string=? key (first (first lassoc)))
     (first lassoc)]
    [else (find-association key (rest lassoc) default)]))

; LLists -> Number
; Produce the sum of each track's the play time
(check-expect (total-time/list LLists1) 0)
(check-expect (total-time/list LLists2) 227996)
(define (total-time/list ll)
  (cond
    [(empty? ll) 0]
    [else
     (+ 
      (second
       (find-association
        "Total Time"
        (first ll)
        (list "Total Time" 0)))
      (total-time/list (rest ll)))]))

; (total-time/list list-tracks)
; output: 494030470.

; the output of exercise 200 is 467897977.

; Two outputs are different because their input length is different.

;; (length list-tracks) 1775

;; (define itunes-tracks
;;   (read-itunes-as-tracks ITUNES-LOCATION))
;; (length itunes-tracks) 1667


; LLists -> List-of-strings (set)
(check-expect (boolean-attributes LLists1) '())
(check-expect (boolean-attributes LLists2)
              (list "my-boolean"))

(define (boolean-attributes ll)
  (create-set 
   (cond
     [(empty? ll) '()]
     [else
      (append
       (find-booleans (first ll))
       (boolean-attributes (rest ll)))])))

; LAssoc -> List-of-string
(check-expect (find-booleans LAssoc1) '())
(check-expect (find-booleans LAssoc2)
              (list "my-boolean"))
(define (find-booleans lassoc)
  (cond
    [(empty? lassoc) '()]
    [(boolean?
      (second (first lassoc)))
     (cons
      (first (first lassoc))
      (find-booleans (rest lassoc)))]
    [else (find-booleans (rest lassoc))]))

; (boolean-attributes list-tracks)
; output:
; ("Disabled" "Compilation" "Purchased")
