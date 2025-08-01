;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise265) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; An IR is a strucutre:
; (make-IR String String Number Number)
(define-struct IR [name description cost retail-price])

; Number [List-of IR] -> [List-of IR]
; get a list of IRs that have a sales price below ua.
(check-expect (eliminate-expensive 200
               (list
                (make-IR "phones" "phones" 1000 1200)
                (make-IR "noodle" "noodle" 10 15)
                (make-IR "pen" "pen" 1 3)))
               (list
                (make-IR "noodle" "noodle" 10 15)
                (make-IR "pen" "pen" 1 3)))

(define (eliminate-expensive ua loir)
  (local (
          ; IR -> Boolean
          (define (cheap? ir)
            (< (IR-retail-price ir) ua)))
    (filter cheap? loir)))

; String [List-of IR] -> [List-of IR]
(check-expect (recall "phones"
                      (list
                       (make-IR "phones" "phones" 1000 1200)
                       (make-IR "noodle" "noodle" 10 15)
                       (make-IR "pen" "pen" 1 3)))
              (list
                (make-IR "noodle" "noodle" 10 15)
                (make-IR "pen" "pen" 1 3)))

(define (recall ty loir)
  (local
      (
       ; IR -> Boolean
       (define (not-ty ir)
         (not
          (string=?
          ty
          (IR-name ir))))
       )
    (filter not-ty loir)))

; [List-of String] [List-of String] -> [List-of String]
; output the intersection of l1 and l2
(check-expect (selection
               (list "name1" "name2" "name3")
               (list "name4" "name5" "name3"))
              (list "name3"))
(define (selection l1 l2)
  (local (
          ; String [List-of String] -> Boolean
          (define (contains name)
            (local (
                    ; String -> Boolean
                    ; Output true if an item is equal to name
                    (define (equal item)
                      (string=? item name)
                    ))
            (ormap equal l2))))
          
    (filter contains l1)))
