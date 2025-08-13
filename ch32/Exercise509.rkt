;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise489) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define FONT-SIZE 11)
(define FONT-COLOR "black")
 
; [List-of 1String] -> Image
; renders a string as an image for the editor 
(define (editor-text s)
  (text (implode s) FONT-SIZE FONT-COLOR))
 
(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor [List-of 1String] [List-of 1String])
; interpretation if (make-editor p s) is the state of 
; an interactive editor, (reverse p) corresponds to
; the text to the left of the cursor and s to the
; text on the right

; [List-of 1String] -> Number
(define (text-width s)
  (image-width (editor-text s)))

; [List-of 1String] N -> Editor
(define (split ed0 x)
  (local (
          (define (split/acc ed acc)
            (local 
                (
                 (define one-more-on-pre
                   (cons (first ed) acc))
                 (define one-more-pre-width
                   (text-width one-more-on-pre))
                 )
              (cond
                [(>= x one-more-pre-width)
                 (split/acc (rest ed)
                            one-more-on-pre)]
                [else (make-editor acc ed)])))
          )
    (if (empty? ed0)
        (make-editor '() '())
        (split/acc ed0 '()))))


(check-expect (split
               '()
               0)
              (make-editor
               '()
               '()
               ))

(check-expect (split
               '("h")
               0)
              (make-editor
               '()
               '("h")
               ))

(check-expect (split
               '("h" "e")
               0)
              (make-editor
               '()
               '("h" "e")
               ))

(check-expect (split
               '("h" "e" "l")
               (add1 (image-width (editor-text '("h")))))
              (make-editor
               '("h")
               '("e" "l")
               ))

(check-expect (split
               '("h" "e" "l" "l" "o")
               (add1 (image-width (editor-text '("h" "e" "l")))))
              (make-editor
               '("l" "e" "h")
               '("l" "o")
               ))

