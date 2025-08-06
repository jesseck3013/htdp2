;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise349) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(require 2htdp/abstraction)

; An Attribute is a list with two items:
;   (cons Symbol (cons String '()))

; A Body is [List-of Xexpr.v2]

; An Xul is one of:
; - (cons 'ul [List-of Xli])
; - (cons 'ul (cons [List-of Attribute] [List-of Xli]))

; An Xli is one of:
; - (cons 'li [list-of XWord])
; - (cons 'li (cons [List-of Attributes] [list-of XWord]))

; An Xexpr is one of: 
; – Xul
; – (cons Symbol Body)
; – (cons Symbol (cons [List-of Attribute] Body))

; Attributes-or-X is one of:
; - [List-of Attribute]
; - Xexpr.v2

; An XWord is '(word ((text String))).

