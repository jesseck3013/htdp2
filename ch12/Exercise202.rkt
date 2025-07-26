;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.h
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |12.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))

; modify the following to use your chosen name
(define ITUNES-LOCATION "itunes.xml")
 
; LTracks
(define itunes-tracks
  (read-itunes-as-tracks ITUNES-LOCATION))

(define track1
  (create-track
   "track1"
   "artist1"
   "album1"
   (* 5 60 1000)
   1
   (create-date 2015 7 3 4 0 0)
   1000
   (create-date 2025 7 3 4 0 0)))

(define track2
  (create-track
   "track2"
   "artist2"
   "album2"
   (* 5 60 1000)
   1
   (create-date 2015 7 3 4 0 0)
   1000
   (create-date 2025 7 3 4 0 0)))

; String LTracks -> LTracks
(check-expect (select-album "album1" (list track1 track2))
              (list track1))
(check-expect (select-album "album3" (list track1 track2))
              '())

(define (select-album album lt)
  (cond
    [(empty? lt) '()]
    [else (if
           (string=?
            album
            (track-album (first lt)))
           (cons
            (first lt) (select-album album (rest lt)))
           (select-album album (rest lt)))]))

;(select-album "A Day Without Rain" itunes-tracks)
