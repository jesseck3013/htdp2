;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |12.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; modify the following to use your chosen name
(define ITUNES-LOCATION "itunes.xml")
 
; LTracks
;; (define itunes-tracks
;;   (read-itunes-as-tracks ITUNES-LOCATION))

; Date
(make-date 1995 5 1 2 0 0)
(make-date 2005 6 2 3 0 0)
(make-date 2015 7 3 4 0 0)

; Track
#false

(create-tract
 "track1"
 "artist1"
 "album1"
 (* 5 60 1000)
 1
 (make-date 2015 7 3 4 0 0)
 1000
 (make-date 2025 7 3 4 0 0))

; LTrack

'()

(list
 (create-tract
  "track1"
  "artist1"
  "album1"
  (* 5 60 1000)
  1
  (make-date 2015 7 3 4 0 0)
  1000
  (make-date 2025 7 3 4 0 0)))
