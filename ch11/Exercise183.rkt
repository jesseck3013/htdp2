;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |11|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; 1
(define List1 (cons "a" (list 0 #false)))

(define List1-cons (cons "a" (cons 0 (cons #false '()))))
(define List1-list (list "a" 0 #false))

(check-expect List1-cons List1)
(check-expect List1-list List1)

; 2
(define List2 (list (cons 1 (cons 13 '()))))

(define List2-cons (cons
                    (cons 1 (cons 13 '()))
                    '()))
(define List2-list (list (list 1 13)))

(check-expect List2-cons List2)
(check-expect List2-list List2)

; 3
(define List3 (cons (list 1 (list 13 '())) '()))

(define List3-cons (cons (cons 1
                               (cons 
                                (cons 13 (cons '() '()))
                                '()))
                         '()))
(define List3-list (list (list 1 (list 13 '()))))

(check-expect List3-cons List3)
(check-expect List3-list List3)

; 4
(define List4 (list '() '() (cons 1 '())))

(define List4-cons (cons '()
                         (cons '()
                               (cons (cons 1 '())
                                     '()))))
(define List4-list (list '() '() (list 1)))

(check-expect List4-cons List4)
(check-expect List4-list List4)

; 5
(define List5 (cons "a" (cons (list 1) (list #false '()))))

(define List5-cons (cons "a"
                         (cons
                          (cons 1 '())
                          (cons #false
                                (cons '() '())))))
(define List5-list (list "a" (list 1) #false '()))

(check-expect List5-cons List5)
(check-expect List5-list List5)
