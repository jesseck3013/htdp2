;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise298) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

(define-struct file [name size content])

; A File.v3 is a structure: 
;   (make-file String N String)

(define-struct dir.v3 [name dirs files])

; A Dir.v3 is a structure: 
;   (make-dir.v3 String Dir* File*)
 
; A Dir* is one of: 
; – '()
; – (cons Dir.v3 Dir*)
 
; A File* is one of: 
; – '()
; – (cons File.v3 File*)

(define hang (make-file "hang" 8 " "))
(define draw (make-file "draw" 2 " "))

(define Code (make-dir.v3 "Code" '() (list hang draw)))

(define read!-Docs (make-file "read!" 19 " "))
(define Docs (make-dir.v3 "Docs" '() (list read!-Docs)))

(define Libs (make-dir.v3 "Libs" (list Code Docs) '()))

(define part1 (make-file "part1" 99 " "))
(define part2 (make-file "part2" 52 " "))
(define part3 (make-file "part3" 17 " "))

(define Text (make-dir.v3 "Text"
                          '() (list part1 part2 part3)))

(define read! (make-file "read!" 10 " "))

(define TS (make-dir.v3 "TS"
                        (list Text Libs) (list read!)))

; Dir.v3 -> Number
(check-expect (how-many TS) 7)

(define (how-many d)
  (+ (length (dir.v3-files d))
     (how-many-dirs (dir.v3-dirs d))))

; [List-of Dir.v3] -> Number
(check-expect (how-many-dirs (list Text)) 3)
(define (how-many-dirs dirs)
  (cond
    [(empty? dirs) 0]
    [else (+ (how-many (first dirs))
             (how-many-dirs (rest dirs)))]))

; No matter how complex the data is, lay out the funciton template based on the data definition. If the data definition refer to other data definitions, create auxiluary functions for other data definitions.
; Keep functions simple, design them do one thing for one data definition.
