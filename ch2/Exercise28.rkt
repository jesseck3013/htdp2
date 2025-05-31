;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise5) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

;; base price: 5
;; base attendees: 120

;; price changes %: (/ (- ticket-price 5)  5)
;; (* (/ (/ (- ticket-price 5)  5) 10) 15)

(define Base-Price 5)
(define Base-Attendees 120)
(define Fix-Cost 180)
(define Attendee-Unit-Cost 0.04)
(define Price-Change-Unit 0.1)
(define Attendees-Change-Unit 15)

(define (attendees ticket-price)
  (- Base-Attendees
     (* (/
         (- ticket-price Base-Price)
         Price-Change-Unit)
        Attendees-Change-Unit)))

(attendees 5.10)
(attendees 4.90)

(define (revenue ticket-price)
  (* (attendees ticket-price) ticket-price))

(define (cost ticket-price)
  (+ Fix-Cost (* (attendees ticket-price) Attendee-Unit-Cost)))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

(profit 1) ;; 511.2
(profit 2) ;; 937.2
(profit 3) ;; 1063.2
(profit 4) ;; 889.2
(profit 5) ;; 415.2

