;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |20.3|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; String -> Dir.v3
; creates a representation of the a-path directory 
;(define (create-dir a-path) ...)

(define ch19 (create-dir "../ch19/"))

; Dir.v3 -> Number
(check-expect (how-many ch19) 23)

(define (how-many d)
  (+ (length (dir-files d))
     (how-many-dirs (dir-dirs d))))

; [List-of Dir.v3] -> Number
(define (how-many-dirs dirs)
  (cond
    [(empty? dirs) 0]
    [else (+ (how-many (first dirs))
             (how-many-dirs (rest dirs)))]))

; It works because the data definition is the same and 
; the function in 336 has been tested.
