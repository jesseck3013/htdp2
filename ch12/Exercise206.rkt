;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.h
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |12.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))

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
   (list "Library Folder Count" 1)))
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

