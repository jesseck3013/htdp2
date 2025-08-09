;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |25.1|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; [List-of X] N -> [List-of X]
; keeps the first n items from l if possible or everything
(define (take l n)
  (cond
    [(zero? n) '()]
    [(empty? l) '()]
    [else (cons (first l) (take (rest l) (sub1 n)))]))
 
; [List-of X] N -> [List-of X]
; removes the first n items from l if possible or everything
(define (drop l n)
  (cond
    [(zero? n) l]
    [(empty? l) l]
    [else (drop (rest l) (sub1 n))]))

; [X] [List-of X] N -> [List-of [List-of chunks]]
(define (list->chunks l n)
  (cond
    [(empty? l) '()]
    [else
     (cons (take l n)
           (list->chunks (drop l n) n))]))

(check-expect (list->chunks (list 1 2 3 4 5 6) 2)
              (list
               (list 1 2)
               (list 3 4)
               (list 5 6)))

(check-expect (list->chunks (list 1 2 3 4 5 6 7) 2)
              (list
               (list 1 2)
               (list 3 4)
               (list 5 6)
               (list 7)))

(check-expect (list->chunks '() 2) '())

; [List-of 1String] N -> [List-of String]
(define (bundle s n)
  (map implode (list->chunks s n)))

(check-expect (bundle (explode "abcdefg") 3)
              (list "abc" "def" "g"))

(check-expect (bundle '("a" "b") 3) (list "ab"))

(check-expect (bundle '() 3) '())
 

; String N -> [List-of String]
(check-expect (partition "abcdefg" 2)
              (list "ab"
                    "cd"
                    "ef"
                    "g"))

(define (partition s n)
  (cond
    [(= (string-length s) 0) '()]
    [else
     (local (
             (define partition-len
               (if (> (string-length s) n)
                   n
                   (string-length s)))
             )
     (cons 
      (substring s 0 partition-len)
      (partition (substring s partition-len (string-length s))
                 n)))]))
