;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise97) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game

(define (SIGS? input)
  (or (aim? input)
      (fired? input)))
(big-bang sigs
          [to-draw render]
          [check-with SIGS?]
          [on-tick clock-tick-handler]
          [on-key key-handler])

; A VAnimal is either
; – a VCat
; – a VCham
(define (VAnimal? input)
  (or (VCat? input)
      (VCham? input)))
  
(big-bang animal
          [to-draw render]
          [check-with VAnimal?]
          [on-tick clock-tick-handler]
          [on-key key-handler])


; An Editor is a structure:
;   (make-editor String Number)
; interpretation (make-editor s p) describes an editor
; whose visible text is s with 
; the cursor displayed at position p.
(big-bang ed
          [to-draw render]
          [on-key edit]
          [check-with editor?])
  
