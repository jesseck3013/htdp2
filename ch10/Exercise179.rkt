;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise153) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor Lo1S Lo1S) 
; An Lo1S is one of: 
; – '()
; – (cons 1String Lo1S)

; Editor -> Editor
; moves the cursor position one 1String left, 
; if possible 
(check-expect (editor-lft
               (make-editor '() '()))
              (make-editor '() '()))

(check-expect (editor-lft
               (make-editor (cons "a" '()) '()))
              (make-editor '() (cons "a" '())))
(check-expect (editor-lft
               (make-editor (cons "b"
                                  (cons "a" '())) '()))
              (make-editor (cons "a" '())
                           (cons "b" '())))

(define (editor-lft ed)
  (cond
    [(empty? (editor-pre ed)) ed]
    [else (make-editor
           (rest (editor-pre ed))
           (cons (first (editor-pre ed))
                 (editor-post ed)))]))

; Editor -> Editor
; moves the cursor position one 1String right, 
; if possible 
(check-expect (editor-rgt
               (make-editor '() '()))
              (make-editor '() '()))
(check-expect (editor-rgt
               (make-editor (cons "a" '()) '()))
              (make-editor (cons "a" '()) '()))

(check-expect (editor-rgt
               (make-editor (cons "a" '()) (cons "b" '())))
              (make-editor (cons "b" (cons "a" '())) '()))

(define (editor-rgt ed)
  (cond
    [(empty? (editor-post ed)) ed]
    [else (make-editor
           (cons (first (editor-post ed))
                 (editor-pre ed))
           (rest (editor-post ed)))]))

; Editor -> Editor
; deletes a 1String to the left of the cursor,
; if possible
(check-expect (editor-del
               (make-editor '() '()))
              (make-editor '() '()))

(check-expect (editor-del
               (make-editor (cons "a" '()) '()))
              (make-editor '() '()))
(check-expect (editor-del
               (make-editor (cons "b"
                                  (cons "a" '())) '()))
              (make-editor (cons "a" '())
                           '()))

(define (editor-del ed)
  (cond
    [(empty? (editor-pre ed)) ed]
    [else (make-editor
           (rest (editor-pre ed))
           (editor-post ed))]))
