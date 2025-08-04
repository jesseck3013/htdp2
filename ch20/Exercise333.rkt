;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise298) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

(define-struct dir [name content])

; A Dir.v2 is a structure: 
;   (make-dir String LOFD)
 
; An LOFD (short for list of files and directories) is one of:
; – '()
; – (cons File.v2 LOFD)
; – (cons Dir.v2 LOFD)
 
; A File.v2 is a String.

(define Text (make-dir "Text"
                       (list "part1" "part2" "part3")))

(define Code (make-dir "Code"
                       (list "hang" "draw")))

(define Docs (make-dir "Docs"
                       (list "read!")))

(define Libs (make-dir "Libs"
                      (list Code Docs)))

(define TS (make-dir "TS"
                     (list Text "read!" Libs)))

; Dir.v2 -> Number
(check-expect (how-many TS) 7)

(define (how-many d)
  (how-many-lofd (dir-content d)))

; LOFD -> Number
(check-expect (how-many-lofd (list "xx"
                                   Text)) 4)
(define (how-many-lofd lofd)
  (cond
    [(empty? lofd) 0]
    [(string? (first lofd))
     (add1 (how-many-lofd (rest lofd)))]
    [else (+ (how-many (first lofd))
             (how-many-lofd (rest lofd)))]))
