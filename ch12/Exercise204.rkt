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

(define track3
  (create-track
   "track3"
   "artist1"
   "album1"
   (* 5 60 1000)
   1
   (create-date 2015 7 3 4 0 0)
   1000
   (create-date 2025 7 3 4 0 0)))

; LTracks -> List-of-LTracks
(check-member-of (select-albums (list track1 track2))
              (list
               (list track1)
               (list track2))
              (list
               (list track2)
               (list track1)))

(check-expect (select-albums '()) '())

(define (select-albums lt)
  (cond
    [(empty? lt) '()]
    [else
     (insert (first lt) (select-albums (rest lt)))]))

; track List-of-LTracks -> List-of-LTracks
(check-expect (insert track3
                      (list
                       (list track1)
                       (list track2)))
              (list
               (list track3 track1)
               (list track2)))
(define (insert t lt)
  (cond
    [(empty? lt) (list (list t))]
    [(string=? (track-album t)
               (track-album (first (first lt))))
     (cons 
      (cons t (first lt))
      (rest lt))]
    [else
     (cons (first lt)
           (insert t (rest lt)))]))

;(first (select-albums itunes-tracks))
