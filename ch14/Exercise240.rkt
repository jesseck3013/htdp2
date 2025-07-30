;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |14.1|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

(define-struct layer [stuff])

; An LStr is one of: 
; – String
; – (make-layer LStr)
"test"
(make-layer "test")
(make-layer (make-layer "test"))

; An LNum is one of: 
; – Number
; – (make-layer LNum)
10
(make-layer 10)
(make-layer (make-layer 10))

; Abstraction:
; An [Layer-of Item ]is one of:
; - Item
; - (make-layer LItem)

; An [Layer-of String] is an an LItem where Item is String:
; - String
; - (make-layer LStr)

; An [Layer-of Number] is an an LItem where Item is Number:
; - Number
; - (make-layer LNum)
