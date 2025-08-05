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

; A Path is [List-of String].
; interpretation directions into a directory tree

; Dir.v3 String -> [List-of Path]
(check-expect (find-all Text "part1")
              (list
               (list "Text" "part1")))

(check-expect (find-all TS "part1")
              (list
               (list "TS" "Text" "part1")))

(check-member-of (find-all TS "read!")
              (list
               (list "TS" "read!")
               (list "TS" "Libs" "Docs" "read!"))
              (list
               (list "TS" "Libs" "Docs" "read!")
               (list "TS" "read!")
               ))

(define (find-all d f)
  (cond
    [(equal? (dir-name d) f)
     (cons (list f)
           (insert-all
            (dir-name d)
            (append (find-all-dirs (dir-dirs d) f)
                    (find-all-files (dir-files d) f))))]
    [else
     (insert-all
      (dir-name d)
      (append (find-all-dirs (dir-dirs d) f)
              (find-all-files (dir-files d) f)))]))

; String [List-of Path] -> [List-of Path]
(check-expect (insert-all "a"
                          (list 
                           (list "b" "c")
                           (list "b" "c" "d")))
              (list
               (list "a" "b" "c")
               (list "a" "b" "c" "d")))
(define (insert-all s ps)
  (map (lambda (item)
         (cons s item)) ps))

; [List-of Dir.v3] -> [List-of [List-of Path]]
(define (find-all-dirs ds f)
  (foldr
   append
   '()
   (remove-empty-list
    (map (lambda (d)
           (find-all d f)) ds))))

; [List-of File.v3] -> [List-of Path]
(check-expect (find-all-files
               (list part1 part2 part1) "part1")
              (list
               (list "part1")
               (list "part1")))
(define (find-all-files fs f)
  (remove-empty-list
   (map (lambda (item)
          (if (equal?
               (file-name item) f)
              (list f)
              '())) fs)))

; X must be a List
; [X] [List-of X] -> [List-of X]
(check-expect (remove-empty-list
               (list
                (list 1 2 3)
                '()
                (list 4 5 6))) (list
                                (list 1 2 3)
                                (list 4 5 6)))
(define (remove-empty-list llx)
  (foldr (lambda (item rst)
           (if (empty? item)
               rst
               (cons item rst))) '() llx))


; When (find? d f) is #false, find-all produce an empty list.
