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

; A Path is [List-of String].
; interpretation directions into a directory tree

; Dir.v3 -> [List-of Path]
(check-expect (ls-R Text) (list
                           (list "Text" "part1")
                           (list "Text" "part2")
                           (list "Text" "part3")))
(check-expect (ls-R Libs) (list
                           (list "Libs" "Code" "hang")
                           (list "Libs" "Code" "draw")
                           (list "Libs" "Docs" "read!")))

(define (ls-R d)
  (insert-all (dir-name d)
   (append (ls-R-dirs (dir-dirs d))
           (ls-R-files (dir-files d)))))

; [List-of Dir.v3] -> [List-of Path]
(check-expect (ls-R-dirs (list Text))
              (list
               (list "Text" "part1")
               (list "Text" "part2")
               (list "Text" "part3")))
(define (ls-R-dirs ds)
  (cond
    [(empty? ds) '()]
    [else
     (append
      (ls-R (first ds))
      (ls-R-dirs (rest ds)))]))

; [List-of File.v3] -> [List-of Path]
(check-expect (ls-R-files (list part1 part2 part3))
              (list
               (list "part1")
               (list "part2")
               (list "part3")))
(define (ls-R-files fs)
  (cond
    [(empty? fs) '()]
    [else
     (cons
      (list (file-name (first fs)))
      (ls-R-files (rest fs)))]))

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

; Dir.v3 -> [List-of Path]
(define (find-all d target-file)
  (local (
          ; Path -> String
          (define (get-last-item p)
            (cond
              [(empty? (rest p)) (first p)]
              [else (get-last-item (rest p))]))

          (define all-path (ls-R d))

          ; [List-of Path] -> [List-of Path]
          (define (get-matched lop)
            (cond
              [(empty? lop) '()]
              [(string=? target-file
                         (get-last-item (first lop)))
               (cons (first lop) (get-matched (rest lop)))]
              [else (get-matched (rest lop))]))
          )
    (get-matched all-path)
    ))

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
