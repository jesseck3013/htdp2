;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise298) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

(define-struct child [father mother name date eyes])

; A Child is a structure: 
;   (make-child Child Child String N String)

(define-struct no-parent [])

; An FT (short for family tree) is one of: 
; – (make-no-parent)
; – (make-child FT FT String N String)

(define NP (make-no-parent))
; An FT is one of: 
; – NP
; – (make-child FT FT String N String)

; An FF (short for family forest) is 
; [List-of FT]
; interpretation a family forest represents several
; families (say, a town) and their ancestor trees

; Oldest Generation:
(define Carl (make-child NP NP "Carl" 1926 "green"))
(define Bettina (make-child NP NP "Bettina" 1926 "green"))
 
; Middle Generation:
(define Adam (make-child Carl Bettina "Adam" 1950 "hazel"))
(define Dave (make-child Carl Bettina "Dave" 1955 "black"))
(define Eva (make-child Carl Bettina "Eva" 1965 "blue"))
(define Fred (make-child NP NP "Fred" 1966 "pink"))
 
; Youngest Generation: 
(define Gustav (make-child Fred Eva "Gustav" 1988 "brown"))

; FT -> Boolean
; does an-ftree contain a child
; structure with "blue" in the eyes field
 
(check-expect (blue-eyed-child? Carl) #false)
(check-expect (blue-eyed-child? Gustav) #true)
 
(define (blue-eyed-child? an-ftree)
  (cond
    [(no-parent? an-ftree) #false]
    [else (or (string=? (child-eyes an-ftree) "blue")
              (blue-eyed-child? (child-father an-ftree))
              (blue-eyed-child? (child-mother an-ftree)))]))

; Forest Examples:
(define ff1 (list Carl Bettina))
(define ff2 (list Fred Eva))
(define ff3 (list Fred Eva Carl))


; FT -> Number
; count the number of child structure in the given family tree
(check-expect (count-persons NP) 0)
(check-expect (count-persons Carl) 1)
(check-expect (count-persons Gustav) 5)

(define (count-persons ft)
  (cond
    [(no-parent? ft) 0]
    [else
     (+ 1 (count-persons (child-father ft))
          (count-persons (child-mother ft)))]))

; FT -> Number
; sum the age of all child in the given family tree
(check-expect (sum-persons-age NP 2025) 0)
(check-expect (sum-persons-age Carl 2025) 99)
(check-expect (sum-persons-age Gustav 2025) 354)
(define (sum-persons-age ft current-year)
  (cond
    [(no-parent? ft) 0]
    [else
     (local (
             (define age
               (- current-year
                  (child-date ft)))
             )
     (+ age
             (sum-persons-age (child-father ft)
                              current-year)
             (sum-persons-age (child-mother ft)
                              current-year)))]))

; [List-of FT] -> Number
; Compute the average age of the given forest.

(check-expect (average-age ff1) 99)
(check-expect (average-age ff2) 79.25)
(check-expect (average-age ff3) 83.2)

(define (average-age a-forest)
  (local (
          (define sum-age
            (foldr + 0
                   (map
                    (lambda (ft)
                      (sum-persons-age ft 2025)) a-forest)))
            
          (define num-of-person
            (foldr + 0 (map count-persons a-forest)))
          )
    (/ sum-age num-of-person)))
