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


; Dir.v3 String -> [Maybe Path]
(check-expect (find ch19 "not_exist") #false)
(check-expect (find TS "part1") (list "TS" "Text" "part1"))
(check-expect (find TS "Code") (list "TS" "Libs" "Code"))
(define (find d f)
  (local (
          ; [List-of [Maybe Path]] -> [Maybe Path]
          (define (non-false-item lop)
            (cond
              [(empty? lop) #false]
              [(boolean? (first lop))
               (non-false-item (rest lop))]
              [else (first lop)]))

          (define dirs-result
            (non-false-item (find-dirs (dir-dirs d) f)))
          )
  (cond
    [(string=? (dir-name d) f) (list (dir-name d))]
    [(find-file? (dir-files d) f) (list (dir-name d) f)]
    [(empty? (dir-dirs d)) #false]
    [(boolean? 
      dirs-result)
     #false]
    [else (cons (dir-name d)
                dirs-result)])))

; [List-of Dir.v3] String -> [List-of [Maybe Path]]
(define (find-dirs d f)
  (map (lambda (item)
         (find item f)) d))


; [List-of File.v3] String -> Boolean
(define (find-file? fs name)
  (ormap (lambda (item)
           (string=?
            (file-name item)
            name)) fs))
