 ;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise97) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; Spider is a structure:
; (make-struct Number Number)
; interpretation (make-struct l s) means a spider has l legs and needs s space for transport.
(define-struct spider [legs space])

; Elephant is a structure:
; (make-structure Number)
; interpretation (make-struct s) means an elephant that needs
; s space for transport.
(define-struct elephant [space])

; Boa-constrictor is a structure
; (make-boa-constrictor [Number Number])
; interpretation (make-boa-constrictor l g) means
; a boa constrictor that has l length and g girth
(define-struct boa-constrictor [length girth])

; Armadillo is a structure
; (make-armadillo [Number])
; interpretation (make-armadillo s) means
; a armadillo needs s space for transport
(define-struct armadillo [space])

; Animal is one of :
; 1. Spider
; 2. Elephant
; 3. Boa-constrictor
; 4. Armadillo

; A function template that consume an Animal
(define (f animal)
  (cond
    [(spider? animal)
     ...(spider-leg animal)...(spider-space animal)]
    [(elephant? animal) ...(elephant-space animal)]
    [(boa-constrictor? animal)
     ...(boa-constrictor-length animal)...
     ...(boa-constrictor-girth animal)...]
    [(armadillo? animal) ...(armadillo-space animal)...]))

; Animal Number -> Boolean
(check-expect (fits? (make-spider 10 10) 10) #true)
(check-expect (fits? (make-spider 10 20) 10) #false)

(check-expect (fits? (make-elephant 10) 10) #true)
(check-expect (fits? (make-elephant 20) 10) #false)

(check-expect (fits? (make-boa-constrictor 2 5) 10) #true)
(check-expect (fits? (make-boa-constrictor 10 20) 10) #false)

(check-expect (fits? (make-armadillo 10) 10) #true)
(check-expect (fits? (make-armadillo 20) 10) #false)
(define (fits? animal cage)
  (cond
    [(spider? animal)
     (<= (spider-space animal) cage)]
    [(elephant? animal) (<= (elephant-space animal) cage)]
    [(boa-constrictor? animal)
     (<= (*
          (boa-constrictor-length animal)          
          (boa-constrictor-girth animal))
         cage)]
    [(armadillo? animal)
     (<= (armadillo-space animal) cage)]))
