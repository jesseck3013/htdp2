;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname data_info) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define-struct editor [content position])
; An Editor is a structure:
;   (make-editor String Number)
; interpretation (make-editor s p) describes an editor
; whose visible text is s with 
; the cursor displayed at position p.

(define example-editor (make-editor "hello world" 5))

; Editor -> String
; get the string before the cursor
(check-expect (editor-pre example-editor) "hello")
(define (editor-pre ed)
  (if
    (> (string-length (editor-content ed)) 0)
   (substring (editor-content ed) 0 (editor-position ed))
   (editor-content ed)))

; Editor -> String
; get the string after the cursor
(check-expect (editor-post example-editor) " world")
(define (editor-post ed)
  (if
    (> (string-length (editor-content ed)) 0)
   (substring (editor-content ed)
              (editor-position ed)
              (string-length (editor-content ed)))
   (editor-content ed)))

(define BG (empty-scene 200 20))
(define CURSOR (rectangle 1 20 "solid" "red"))

; String -> Image
; render a string as black text of size 16
(define (render-text t)
  (text t 16 "black"))
(check-expect (render-text "hello") (text "hello" 16 "black"))

; Editor -> Image
; render text and cursor
(check-expect (render-content
               example-editor)
              (beside 
               (render-text "hello")
               CURSOR
               (render-text " world")))
(define (render-content ed)
         (beside
          (render-text (editor-pre ed))
          CURSOR
          (render-text (editor-post ed))))

; Editor -> Image
; render an image based on an Editor structure
(check-expect (render example-editor)
              (overlay/align "left" "center"
                 (render-content example-editor)
                 BG))
(define (render ed)
  (overlay/align "left" "center"
                 (render-content ed)
                 BG))

; String -> String
; remove the i-th position 1string of s
(check-expect (remove-ith "hello" 1) "hllo")
(check-expect (remove-ith "" 1) "")
(check-expect (remove-ith "" 0) "")
(define (remove-ith s i)
  (if (> (string-length s) 0)
      (string-append (substring s 0 i)
                     (substring s (+ i 1) (string-length s)))
      s))

; Editor -> Editor
; remove a 1String before cursor
(check-expect (delete-1string-before example-editor)
              (make-editor "hell world" 4))
(check-expect
 (delete-1string-before (make-editor "h" 1))
              (make-editor "" 0))
(define (delete-1string-before ed)
  (if (> (editor-position ed) 0)
      (make-editor
       (remove-ith (editor-content ed)
                   (- (editor-position ed) 1))
       (- (editor-position ed) 1))
      ed))

; Editor -> Editor
; move cursor left by a 1String place
(check-expect (cursor-left example-editor)
              (make-editor "hello world" 4))
(check-expect (cursor-left (make-editor "hello world" 0))
              (make-editor "hello world" 0))
(define (cursor-left ed)
  (if
   (and (> (editor-position ed) 0)
        (> (string-length (editor-content ed)) 0))
      (make-editor
       (editor-content ed)
       (- (editor-position ed) 1))
      ed))

; Editor -> Editor
; move cursor right by a 1String place
(check-expect (cursor-right example-editor)
              (make-editor "hello world" 6))
(check-expect (cursor-right (make-editor "hello world" 10))
              (make-editor "hello world" 10))
(define (cursor-right ed)
  (if (<= (editor-position ed)
          (- (string-length (editor-content ed)) 1))
      (make-editor
       (editor-content ed)
       (+ (editor-position ed) 1))
      ed))

; Editor -> Number
; get the width of the current content of Editor
(check-expect (content-width (make-editor "hello" "world"))
              (image-width (render-content e)))
(define (content-width e)
  (image-width (render-content e)))

; Editor, String -> Editor
; Insert a 1String at cursor position
(check-expect (insert example-editor "b")
              (make-editor "hellob world" 6))
(define (insert ed ke)
  (make-editor
   (string-append 
    (string-append (editor-pre ed) ke)
    (editor-post ed))
   (+ (editor-position ed) 1)))

; Editor -> Editor 
; update Editor ed based on key event ke
(define (edit ed ke)
  (cond 
    [(or (string=? ke "\t")
         (string=? ke "\r")) ed]
    [(string=? ke "\b") (delete-1string-before ed)]
    [(string=? ke "left") (cursor-left ed)]
    [(string=? ke "right") (cursor-right ed)]
    [else (if (< (content-width (insert ed ke))
                 (image-width BG))
              (insert ed ke)
              ed)]))

; when ke is \t or \r
(check-expect
 (edit example-editor "\t") example-editor)
(check-expect
 (edit example-editor "\r") example-editor)

; when ke is left
(check-expect
 (edit example-editor "left") (make-editor "hello world" 4))
(check-expect
 (edit (make-editor "hello world" 0) "left") (make-editor "hello world" 0))
(check-expect
 (edit (make-editor "" 0) "left") (make-editor "" 0))

; when ke is right
(check-expect
 (edit example-editor "right") (make-editor "hello world" 6))
(check-expect
 (edit (make-editor "" 0) "right") (make-editor "" 0))
(check-expect
 (edit (make-editor "hello world" 11) "right") (make-editor "hello world" 11))

; when ke is other keys
(check-expect
 (edit example-editor "b") (make-editor "hellob world" 6))
(check-expect
 (edit (make-editor "" 0) "b") (make-editor "b" 1))
(check-expect
 (edit (make-editor "xx" 2) "b") (make-editor "xxb" 3))

; Laugn the graphical interative editor.
(define (run ed)
  (big-bang ed
            [to-draw render]
            [on-key edit]))

(run example-editor)
