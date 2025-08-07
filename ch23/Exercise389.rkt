;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define-struct phone-record [name number])
; A PhoneRecord is a structure:
;   (make-phone-record String String)

(define u1 "user1")
(define u2 "user2")
(define u3 "user3")
(define ul `(,u1 ,u2 ,u3))

(define p1 "000-000-0001")
(define p2 "000-000-0002")
(define p3 "000-000-0003")
(define pl `(,p1 ,p2 ,p3))

; [List-of String] [List-of String] -> [List-of PhoneRecord]
(check-expect (zip ul pl)
              (list (make-phone-record u1 p1)
                    (make-phone-record u2 p2)
                    (make-phone-record u3 p3)))
(define (zip lou lop)
  (cond
    [(empty? lou) '()]
    [else
     (local (
             (define user (first lou))
             (define phone (first lop))
             (define pr (make-phone-record user phone))
             )
       (cons pr
             (zip (rest lou)
                  (rest lop))))]))
