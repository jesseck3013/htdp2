;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname data_info) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

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
