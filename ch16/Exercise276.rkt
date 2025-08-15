;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise246) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; modify the following to use your chosen name
(define ITUNES-LOCATION "../ch12/itunes.xml")
 
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

; String date LTracks -> LTracks
(check-expect
 (select-album-date
  "album1"
  (create-date 2005 1 1 0 0 0)
  (list track1 track2)) (list track1))

(check-expect
 (select-album-date
  "album1"
  (create-date 2027 1 1 0 0 0)
  (list track1 track2)) '())

(check-expect
 (select-album-date
  "album1"
  (create-date 2025 1 1 0 0 0)
  '()) '())

(define (select-album-date album since lt)
  (local ((define (condition track)
            (match? album since track)))
  (filter condition lt)))

; String date track -> Boolean
(check-expect
 (match? "album1" (create-date 2005 1 1 0 0 0) track1)
 #true)
(check-expect
 (match? "album2" (create-date 2005 1 1 0 0 0) track1)
 #false)
(check-expect
 (match? "album1" (create-date 2027 1 1 0 0 0) track1)
 #false)
(define (match? album since tr)
  (and (string=? album (track-album tr))
       (before since (track-played tr))))

; date date -> Boolean
(check-expect
 (before (create-date 2024 7 26 0 0 0)
         (create-date 2025 7 26 0 0 0))
 #true)

(check-expect
 (before (create-date 2025 7 26 0 0 0)
         (create-date 2024 7 26 0 0 0))
 #false)

(check-expect
 (before (create-date 2025 6 26 0 0 0)
         (create-date 2025 7 26 0 0 0))
 #true)

(check-expect
 (before (create-date 2025 7 26 0 0 0)
         (create-date 2025 6 26 0 0 0))
 #false)

(check-expect
 (before (create-date 2025 6 26 0 0 0)
         (create-date 2025 6 27 0 0 0))
 #true)

(check-expect
 (before (create-date 2025 6 28 0 0 0)
         (create-date 2025 6 27 0 0 0))
 #false)

(check-expect
 (before (create-date 2025 6 27 1 0 0)
         (create-date 2025 6 27 2 0 0))
 #true)

(check-expect
 (before (create-date 2025 6 27 1 0 0)
         (create-date 2025 6 27 0 0 0))
 #false)

(check-expect
 (before (create-date 2025 6 27 0 0 0)
         (create-date 2025 6 27 0 1 0))
 #true)

(check-expect
 (before (create-date 2025 6 27 0 1 0)
         (create-date 2025 6 27 0 0 0))
 #false)

(check-expect
 (before (create-date 2025 6 27 0 0 0)
         (create-date 2025 6 27 0 0 1))
 #true)

(check-expect
 (before (create-date 2025 6 27 0 0 1)
         (create-date 2025 6 27 0 0 0))
 #false)

(define (before d1 d2)
  (cond
    [(= (date-year d1)
        (date-year d2))
     (cond
       [(= (date-month d1)
           (date-month d2))
        (cond
          [(= (date-day d1)
              (date-day d2))
           (cond
             [(= (date-hour d1)
                 (date-hour d2))
              (cond
                [(= (date-minute d1)
                    (date-minute d2))
                 (cond
                   [(= (date-second d1)
                       (date-second d2)) #false]
                   [else (< (date-second d1)
                            (date-second d2))])]
                [else (< (date-minute d1)
                         (date-minute d2))])]
             [else (< (date-hour d1)
                      (date-hour d2))])]
          [else (< (date-day d1)
                   (date-day d2))])]
       [else (< (date-month d1)
                (date-month d2))])]
    [else (< (date-year d1)
             (date-year d2))]))

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
  (foldr insert '() lt))

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
