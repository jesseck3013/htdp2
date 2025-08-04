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

(define ch19 (create-dir "../ch19/"))

; Dir.v3 String -> Boolean
(check-expect (find? ch19 "19.1.rkt") #true)

(define (find? d fn)
  (or (find-dirs? (dir-dirs d) fn)
      (find-files? (dir-files d) fn)))

; [List-of Dir.v3] String -> Boolean
(check-expect
 (find-dirs? (list
              (make-dir "temp" '()
                        (list (make-file "xx" 10 " "))))
             "19.1.rkt")
 #false)

(check-expect
 (find-dirs? (list
              (make-dir "temp" '()
                        (list (make-file "19.1.rkt" 10 " "))))
             "19.1.rkt")
 #true)

(define (find-dirs? ds fn)
  (ormap (lambda (item)
           (find? item fn)) ds))

; [List-of File.v3] String -> Boolean
(check-expect (find-files? (list (make-file "xx" 10 " ")) "19.1.rkt") #false)
(check-expect (find-files?
               (list
                (make-file "xx" 10 " ")
                (make-file "19.1.rkt" 10 " "))
               "19.1.rkt") #true)

(define (find-files? fs fn)
  (ormap (lambda (item)
           (equal? (file-name item) fn)) fs))
