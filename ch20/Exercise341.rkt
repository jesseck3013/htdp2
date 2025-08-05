;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |20.3|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; A File.v3 is a structure: 
;   (make-file String N String)

; A Dir.v3 is a structure: 
;   (make-dir.v3 String Dir* File*)
 
; A Dir* is one of: 
; – '()
; – (cons Dir.v3 Dir*)
 
; A File* is one of: 
; – '()
; – (cons File.v3 File*)

; String -> Dir.v3
; creates a representation of the a-path directory 
;(define (create-dir a-path) ...)

(define hang (make-file "hang" 8 " "))
(define draw (make-file "draw" 2 " "))

(define Code (make-dir "Code" '() (list hang draw)))

(define read!-Docs (make-file "read!" 19 " "))
(define Docs (make-dir "Docs" '() (list read!-Docs)))

(define Libs (make-dir "Libs" (list Code Docs) '()))

(define part1 (make-file "part1" 99 " "))
(define part2 (make-file "part2" 52 " "))
(define part3 (make-file "part3" 17 " "))

(define Text (make-dir "Text"
                          '() (list part1 part2 part3)))

(define read! (make-file "read!" 10 " "))

(define TS (make-dir "TS"
                     (list Text Libs) (list read!)))

; Dir.v3 -> Number
(check-expect (du TS) (+ 8 2 19 10 99 52 17 5))
(check-expect (du Text) (+ 1 99 52 17))
(define (du directory)
  (+ (du-dirs (dir-dirs directory))
     (du-files (dir-files directory))
     1))

; [List-of Dir.v3] -> Nubmer
(check-expect (du-dirs (list Text)) (+ 1 99 52 17))
(define (du-dirs ds)
  (foldr (lambda (item rst)
           (+ (du item)
              rst)) 0 ds))

; [List-of File.v3] -> Nubmer
(check-expect (du-files (dir-files Text)) (+ 99 52 17))
(define (du-files fs)
  (foldr (lambda (item rst)
           (+ (file-size item) rst)) 0 fs))

