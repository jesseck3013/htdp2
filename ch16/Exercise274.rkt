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
  (cond
    [(empty? s) '()]
    [else
     (add-prefix
      (first s)
      (prefixes (rest s)))]))

; 1String [List-of [List-of String]] -> [List-of [List-of String]]
;; (check-expect (insert "a" (list (list "b")))
;;                 (list
;;                  (list "a" "b")
;;                  (list "a")))
;; (define (insert s los)
;;   (cond
;;     [(empty? los) (cons (list s) '())]
;;     [else (cons
;;            (cons s (first los))
;;            (insert s (rest los)))]))
