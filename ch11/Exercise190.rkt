;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |11|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; List-of-1Strings -> List-of-List-of-1Strings
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

(define (prefixes s)
  (cond
    [(empty? s) '()]
    [else
     (add-prefix
      (first s)
      (prefixes (rest s)))]))

; 1String List-of-List-of-1Strings -> List-of-List-of-1Strings
(check-expect (add-prefix "a"
                          '())
              (list (list "a")))

(check-expect (add-prefix "a"
                          (list
                           (list "b")
                           (list "b" "c")))
              (list
               (list "a" "b")
               (list "a" "b" "c")
               (list "a")))
(define (add-prefix s llos)
  (cond
    [(empty? llos) (list (list s))]
    [else (cons (cons s (first llos))
                (add-prefix s (rest llos)))]))


; List-of-1Strings -> List-of-List-of-1Strings
(check-expect (suffix '()) '())
(check-expect (suffix (list "a")) (list (list "a")))
(check-expect (suffix (list "a" "b"))
              (list (list "a" "b")
                    (list "b")))
(check-expect (suffix (list "a" "b" "c"))
              (list (list "a" "b" "c")
                    (list "b" "c")
                    (list "c")))

(define (suffix los)
  (cond
    [(empty? los) '()]
    [else (append (list los)
                  (suffix (rest los)))]))
