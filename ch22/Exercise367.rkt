;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise349) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; An Xexpr.v2 is a list: 
; – (cons Symbol Body)
; – (cons Symbol (cons [List-of Attribute] Body))
; where Body is short for [List-of Xexpr.v2]
; An Attribute is a list of two items:
;   (cons Symbol (cons String '()))

; The self referencing part is
; – (cons Symbol Body)
; -                \
; -              [List-of Xexpr.v2]


; – (cons Symbol (cons [List-of Attribute] Body))
;                                           \
; -                                 [List-of Xexpr.v2]

; The template is not recursive because the parsing function
; is not designed to retrieve all the names, attrs and contents of the given Xexpr.v2 but only the first layer.

; Recursive Template:
    (define (xexpr-attr xe)
      (local ((define optional-loa+content (rest xe)))
        (cond
          [(empty? optional-loa+content) ...]
          [else (... (first optional-loa+content)
                 ... (xexpr-attr (rest optional-loa+content)) ...)])))

