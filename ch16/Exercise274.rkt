;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise265) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

(check-expect (prefixes '()) '())

(check-expect (prefixes (list "a")) (list (list "a")))

(check-expect (prefixes (list "a" "b"))
              (list (list "a" "b")
                    (list "a")))

(check-expect (prefixes (list "a" "b" "c"))
              (list
               (list "a" "b" "c")
               (list "a" "b")
               (list "a")))

(check-expect (prefixes (list "a" "b" "c" "d"))
              (list (list "a" "b" "c" "d")
                    (list "a" "b" "c")
                    (list "a" "b")
                    (list "a")))

; [List-of 1String] -> [List-of [List-of 1String]]
(define (prefixes s)
  (reverse
   (map (lambda (outter)
         (foldr (lambda (inner rst)
                  (if (string=? outter inner)
                      (list inner)
                      (cons inner rst))) '() s)) s)))

; List-of-1Strings -> List-of-List-of-1Strings
(check-expect (suffixes '()) '())
(check-expect (suffixes (list "a")) (list (list "a")))
(check-expect (suffixes (list "a" "b"))
              (list (list "a" "b")
                    (list "b")))
(check-expect (suffixes (list "a" "b" "c"))
              (list (list "a" "b" "c")
                    (list "b" "c")
                    (list "c")))

(define (suffixes s)
   (map (lambda (outter)
          (reverse
           (foldl (lambda (inner rst)
                  (if (string=? outter inner)
                      (list inner)
                      (cons inner rst))) '() s))) s))
