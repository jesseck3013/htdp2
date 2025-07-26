;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.h
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |12.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))

; modify the following to use your chosen name
(define ITUNES-LOCATION "itunes.xml")
 
; LTracks
(define itunes-tracks
  (read-itunes-as-tracks ITUNES-LOCATION))

; LTracks -> List-of-strings
(check-expect (select-all-album-titles '()) '())
(check-expect (select-all-album-titles
               (list
                (create-track
                 "track1"
                 "artist1"
                 "album1"
                 (* 5 60 1000)
                 1
                 (create-date 2015 7 3 4 0 0)
                 1000
                 (create-date 2025 7 3 4 0 0)))
               ) (list "album1"))
(define (select-all-album-titles lt)
  (cond
    [(empty? lt) '()]
    [else (cons
           (track-album (first lt))
           (select-all-album-titles (rest lt)))]))

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
    [(existed?
      (first los) (rest los))
     (create-set (rest los))]
    [else (cons (first los) (create-set (rest los)))]))

; String List-of-strings -> Boolean
(check-expect (existed? "album1" '()) #false)
(check-expect (existed? "album1" (list "album2")) #false)
(check-expect (existed? "album1" (list "album1")) #true)
(define (existed? s los)
  (cond
    [(empty? los) #false]
    [else (if (string=? s (first los))
              #true
              (existed? s (rest los)))]))

; LTracks -> List-of-strings
; get a list of unique album names
(check-expect (select-all-album-titles/unique '()) '())
(check-expect (select-all-album-titles/unique
               (list
                (create-track
                 "track1"
                 "artist1"
                 "album1"
                 (* 5 60 1000)
                 1
                 (create-date 2015 7 3 4 0 0)
                 1000
                 (create-date 2025 7 3 4 0 0))
                (create-track
                 "track1"
                 "artist1"
                 "album1"
                 (* 5 60 1000)
                 1
                 (create-date 2015 7 3 4 0 0)
                 1000
                 (create-date 2025 7 3 4 0 0))))
              (list "album1"))
(define (select-all-album-titles/unique lt)
  (create-set (select-all-album-titles lt)))

;(select-all-album-titles/unique itunes-tracks)
; (length (select-all-album-titles/unique itunes-tracks))
; output: 150
