;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise234) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; List-of-songs -> List-of-ranked-songs
(define (ranking los)
  (reverse (add-ranks (reverse los))))

; List-of-songs -> List-of-ranked-songs in reverse order
(define (add-ranks los)
  (cond
    [(empty? los) '()]
    [else (cons (list (length los) (first los))
                (add-ranks (rest los)))]))

(define one-list
  '("Asia: Heat of the Moment"
    "U2: One"
    "The White Stripes: Seven Nation Army"))

(define ranked-one-list (ranking one-list))

; Record is 
; (list number string)

; Record -> html
(check-expect
 (make-row (list 3 "The White Stripes: Seven Nation Army"))
 `(tr
   (td "3")
   (td "The White Stripes: Seven Nation Army")))
(define (make-row l)
  `(tr
    (td ,(number->string (first l)))
    (td ,(second l))))

; List-of-ranked-songs -> html
(check-expect (make-rows ranked-one-list)
              `((tr
                 (td "1")
                 (td "Asia: Heat of the Moment"))
                (tr
                 (td "2")
                 (td "U2: One"))
                (tr
                 (td "3")
                 (td "The White Stripes: Seven Nation Army"))))
(define (make-rows l)
  (cond
    [(empty? l) '()]
    [else (cons
           (make-row (first l))
           (make-rows (rest l)))]))

; List-of-songs -> HTML
(check-expect (make-ranking one-list)
              `(html
                (body
                 (table
                  (tr
                   (td "1")
                   (td "Asia: Heat of the Moment"))
                  (tr
                   (td "2")
                   (td "U2: One"))
                  (tr
                   (td "3")
                   (td "The White Stripes: Seven Nation Army"))))))
     
(define (make-ranking lors)
  `(html
    (body
     (table      
      ,@(make-rows (ranking lors))))))

(make-ranking one-list)
;; output:
;; (html
;;  (body
;;   (table
;;    (tr (td "1") (td "Asia: Heat of the Moment"))
;;    (tr (td "2") (td "U2: One"))
;;    (tr (td "3") (td "The White Stripes: Seven Nation Army")))))


;(show-in-browser (make-ranking one-list))
