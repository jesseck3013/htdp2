;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |25.1|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; - the 1st function call
(quick-sort< (list 10 6 8 9 14 12 3 11 14 16 2))

; - 1 append, 2 recursive calls
(append
 (quick-sort< (list 6 8 9 3 2))
 (list 10)
 (quick-sort< (list 14 12 14 16)))

; - 1 append, 2 recursive calls
(append
 (append
  (quick-sort< (list 3 2))
  (list 6)
  (quick-sort< (list 8 9)))
 (list 10)
 (quick-sort< (list 14 12 14 16)))

; - 1 append, 2 recursive calls
(append
 (append
  (append
   (quick-sort< (list 2))
   (list 3)
   (quick-sort< '()))
  (list 6)
  (quick-sort< (list 8 9)))
 (list 10)
 (quick-sort< (list 14 12 14 16)))

; - 1 append, 2 recursive calls
(append
 (append
  (append
   (list 2)
   (list 3)
   '()
   (list 6)
   (append
    (quick-sort< '())
    (list 8)
    (quick-sort< (list 9)))))
 (list 10)
 (quick-sort< (list 14 12 14 16)))

(append
 (list 2 3 6 8 9)
 (list 10)
 (quick-sort< (list 14 12 14 16)))

; - 1 append, 2 recursive calls
(append
 (list 2 3 6 8 9)
 (list 10)
 (append
 (quick-sort< (list 12)) 
 (list 14 14))
 (quick-sort< (list 16))
 )

(append
 (list 2 3 6 8 9)
 (list 10)
 (append
 (list 12)
 (list 14 14))
 (list 16)
 )

(append
 (list 2 3 6 8 9)
 (list 10)
 (list 12 14 14 16))

(list 2 3 6 8 9 10 12 14 14 16)

; My manual evaluation shows it requires 5 appends and 8 recursive calls.

; Suppose the length of the array is n.
; The number of recursive quick-sort< calls is
; 2 * (ceiling log_2(n))
; The number of appends is (ceiling log_2(n)) + 1

(quick-sort< (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14))

; 1 append, 2 recursive calls
(append
 (quick-sort< '())
 (list 1)
 (quick-sort< (list 2 3 4 5 6 7 8 9 10 11 12 13 14)))

; 1 append, 2 recursive calls
(append
 '()
 (list 1)
 (append
  (quick-sort< '())
  (list 2)
  (quick-sort< (list 3 4 5 6 7 8 9 10 11 12 13 14)))
 )

; ....

; It takes 13 appends, and 26 recursive calls.

; This is the worst case for this algorithm, the previous estimation is the best case.
