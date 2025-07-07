;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname data_info) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define-struct centry [name home office cell])
; (centry-name (make-centry name0 home0 office0 cell0)) name
; (centry-home (make-centry name0 home0 office0 cell0)) home0
; (centry-office (make-centry name0 home0 office0 cell0)) office0
; (centry-cell (make-centry name0 home0 office0 cell0)) cell0

(define-struct phone [area number])
; (phone-area (make-phone area0 number0)) area0
; (phone-number (make-phone area0 number0)) number0

(phone-area
 (centry-office
  (make-centry "Shriram Fisler"
    (make-phone 207 "363-2421")
    (make-phone 101 "776-1099")
    (make-phone 208 "112-9981")))) 
; 101
