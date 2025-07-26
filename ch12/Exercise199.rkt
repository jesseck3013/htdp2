;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise199) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; modify the following to use your chosen name
(define ITUNES-LOCATION "itunes.xml")
 
; LTracks
;; (define itunes-tracks
;;   (read-itunes-as-tracks ITUNES-LOCATION))

; Date
(create-date 1995 5 1 2 0 0)
(create-date 2005 6 2 3 0 0)
(create-date 2015 7 3 4 0 0)

; Track
#false

(create-track
 "track1"
 "artist1"
 "album1"
 (* 5 60 1000)
 1
 (create-date 2015 7 3 4 0 0)
 1000
 (create-date 2025 7 3 4 0 0))

; LTrack

'()

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
