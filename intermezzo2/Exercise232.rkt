;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname quote) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))

(define q1 `(1 "a" 2 #false 3 "c"))
(define l1 (list 1 "a" 2 #false 3 "c"))
(check-expect q1 l1)

(define q2 `(("alan" ,(* 2 500))
             ("barb" 2000)
             (,(string-append "carl" " , the great") 1500)
             ("dawn" 2300)))

(define l2 (list
            (list "alan" 1000)
            (list "barb" 2000)
            (list "carl , the great" 1500)
            (list "dawn" 2300)))

(check-expect q2 l2)

(define title "ratings")

(define q3 `(html
             (head
              (title ,title))
             (body
              (h1 ,title)
              (p "A second web page"))))


(define l3 (list `html
             (list `head
                   (list `title "ratings"))
             (list `body
              (list `h1 "ratings")
              (list `p "A second web page"))))
(check-expect q3 l3)
