#lang racket

; String String -> Boolean
; Determin if s2 starts with s1
(define (start-with s1 s2)
  (cond
    [(= (string-length s1) 0) #true]
    [(= (string-length s2) 0) (= (string-length s1) 0)]
    [else (and (equal? (string-ref s1 0)
                         (string-ref s2 0))
               (start-with (substring s1 1 (string-length s1))
                           (substring s2 1 (string-length s2))))]))

; String [List-of String] -> [Maybe String]
(define (find-name name lon)
  (for/or [(item lon)]
    (if (or (string=? name item) (start-with name item))
        item
        #false)))

(find-name "hello" (list "helloworld" "hello"))
; output: helloworld

; Number [List-of String] -> Boolean
(define (all-strings-length-less-than len los)
  (for/and ([s los])
    (< (string-length s) len)))

(all-strings-length-less-than 6 (list "hello" "world"))
(all-strings-length-less-than 3 (list "hello" "world"))
