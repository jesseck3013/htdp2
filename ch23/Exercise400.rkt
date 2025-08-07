;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

;        search  '()   Non-empty
;pattern          
;  '()           #true  #true
;Non-empty      #false  recursive-call

; [List-of Symbol] [List-of Symbol] -> Boolean
(check-expect (DNAprefix '() '()) #true)
(check-expect (DNAprefix '() '(a)) #true)
(check-expect (DNAprefix '(a) '()) #false)
(check-expect (DNAprefix '(a c g) '(a c g t)) #true)
(check-expect (DNAprefix '(a g c) '(a c g t)) #false)

(define (DNAprefix pattern search)
  (cond
    [(empty? pattern) #true]
    [(empty? search) #false]
    [else (and (equal? (first pattern) (first search))
               (DNAprefix (rest pattern) (rest search)))]))

;        search  '()   Non-empty
;pattern          
;  '()           error  first item
;Non-empty      #false  recursive-call

; [List-of Symbol] [List-of Symbol] -> [Maybe Symbol]
(check-error (DNAdelta '() '()))
(check-expect (DNAdelta '() '(a)) 'a)
(check-expect (DNAdelta '(a) '()) #false)
(check-expect (DNAdelta '(a c g) '(a c g t)) 't)
(check-expect (DNAdelta '(a g c) '(a c g t)) #false)

(define (DNAdelta pattern search)
  (cond
    [(and (empty? pattern) (empty? search))
     (error "Two DNAs are Identical")]
    [(and (not (empty? pattern)) (empty? search)) #false]
    [(and (empty? pattern) (not (empty? search)))
     (first search)]
    [(not (and (empty? pattern) (empty? search)))
     (if (equal? (first pattern) (first search))
         (DNAdelta (rest pattern) (rest search))
         #false)]))
