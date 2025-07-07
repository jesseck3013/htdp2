;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname data_info) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(define-struct movie [title director year])

(... (movie-title m) ...
     ... (movie-director m) ...
     ... (movie-year m) ...)

(define-struct pet [name number])

(... (pet-name p) ...
     (pet-number p) ...)

(define-struct CD [artist title price])
(... (CD-artist cd) ...
     ... (CD-title cd) ...
     ... (CD-price cd) ...)

(define-struct sweater [material size color])
(... (sweater-material  s) ...
     ... (sweater-size s) ...
     ... (sweater-color s) ...)

