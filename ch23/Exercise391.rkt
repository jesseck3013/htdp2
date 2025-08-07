;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; Possible inputs:
; 1. '() '()
; 2. [NEList-of Number] '()
; 3. '() [NEList-of Number]
; 4. [NEList-of Number] [NEList-of Number]

; [List-of Number] [List-of Number] -> [List-of Number]
; replaces the final '() in front with end
(check-expect (replace-eol-with (cons 1 '()) '(a))
              (cons 1 '(a)))
(check-expect (replace-eol-with
                (cons 2 (cons 1 '())) '(a))
              (cons 2 (cons 1 '(a))))

; Systematic Method:
;; (define (replace-eol-with front end)
;;   (cond
;;     [(and (empty? front) (empty? end)) '()]
;;     [(and (not (empty? front)) (empty? end)) front]
;;     [(and (empty? front) (not (empty? end))) end]
;;     [(and (not (empty? front)) (not (empty? end)))
;;      (cons (first front)
;;            (replace-eol-with (rest front) end))]))

; Simplified: 
(define (replace-eol-with front end)
  (cond
    [(empty? front) end]
    [else (cons (first front)
                (replace-eol-with (rest front) end))]))

