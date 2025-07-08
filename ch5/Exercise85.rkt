;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname data_info) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define BG (empty-scene 200 20))
(define CURSOR (rectangle 1 20 "solid" "red"))
(define HELLO-WORLD-RENDER-EXAMPLE
  (overlay/align "left" "center"
                 (beside (text "hello " 16 "black")
                         CURSOR
                         (text "world" 16 "black"))
                 BG))

; String -> Image
; render a string as black text of size 16
(check-expect (render-text "hello") (text "hello" 16 "black"))
(define (render-text t)
  (text t 16 "black"))

; Editor -> Image
; render an image based on an Editor structure
(check-expect (render (make-editor "hello " "world"))
              HELLO-WORLD-RENDER-EXAMPLE)
(define (render e)
  (overlay/align "left" "center"
                 (beside
                  (render-text (editor-pre e))
                  CURSOR
                  (render-text (editor-post e)))
                 BG))

; auxiliary functions
(define (string-first str)
  (substring str 0 1))

(define (string-last str)
  (substring str
             (- (string-length str) 1)
             (string-length str)))

(define (string-rest str)
  (substring str 1 (string-length str)))

(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

(define hello-world-editor (make-editor "hello" "world"))
(define empty-pre-editor (make-editor "" "world"))
(define empty-post-editor (make-editor "hello" ""))

; Editor -> Editor 
; update Editor based on key event
(define (edit ed ke)
  (cond
    [(or (string=? ke "\t")
         (string=? ke "\r")) ed]
    [(string=? ke "\b")
     (if (> (string-length (editor-pre ed)) 0)
         (make-editor (string-remove-last (editor-pre ed))
                      (editor-post ed))
         ed)]
    [(string=? ke "left")
     (if (> (string-length (editor-pre ed)) 0)
         (make-editor (string-remove-last (editor-pre ed))
                      (string-append
                       (string-last (editor-pre ed))
                       (editor-post ed)))
         ed)]
    [(string=? ke "right")
     (if (> (string-length (editor-post ed)) 0)
         (make-editor (string-append
                       (editor-pre ed)
                       (string-first (editor-post ed)))
                      (string-rest (editor-post ed)))
         ed)]
    [else (make-editor
           (string-append (editor-pre ed) ke)
           (editor-post ed))]
    ))

; when ke is \t or \r
(check-expect
 (edit hello-world-editor "\t") hello-world-editor)
(check-expect
 (edit hello-world-editor "\r") hello-world-editor)

; when ke is left
(check-expect
 (edit hello-world-editor "left")
 (make-editor "hell" "oworld"))
(check-expect
 (edit empty-pre-editor "left")
 empty-pre-editor)

; when ke is right
(check-expect
 (edit hello-world-editor "right")
 (make-editor "hellow" "orld"))
(check-expect
 (edit empty-post-editor "right")
 empty-post-editor)

; when ke is other keys
(check-expect
 (edit hello-world-editor "a")
 (make-editor "helloa" "world"))
(check-expect
 (edit empty-pre-editor "a")
 (make-editor "a" "world"))

; Given pre of an editor, launch an interatice editor
(define (run pre)
  (big-bang (make-editor pre "")
            [on-key edit]
            [to-draw render]))

(run "hello")
