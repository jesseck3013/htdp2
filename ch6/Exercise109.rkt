 ;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise97) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; State is one of:
; - AA
; - BB
; - DD
; - ER
(define AA "start, expect and a")
(define BB "expect 'b', 'c', or 'd'")
(define DD "finished")
(define ER "error, illegal key")

; State -> Image
; Render the image based on the given State
(check-expect (render AA) (rectangle 100 100 "solid" "white"))
(check-expect (render BB) (rectangle 100 100 "solid" "yellow"))
(check-expect (render DD) (rectangle 100 100 "solid" "green"))
(check-expect (render ER) (rectangle 100 100 "solid" "red"))
(define (render s)
  (cond
    [(string=? s AA) (rectangle 100 100 "solid" "white")]
    [(string=? s BB) (rectangle 100 100 "solid" "yellow")]
    [(string=? s DD) (rectangle 100 100 "solid" "green")]
    [(string=? s ER) (rectangle 100 100 "solid" "red")]))

; State String -> State
; Update State based on the given key event
(define (key-handler s ke)
  (cond
    [(string=? s AA)
     (if (string=? ke "a")
         BB
         ER)]
    [(string=? s BB)
     (cond
       [(string=? ke "b") BB]
       [(string=? ke "c") BB]
       [(string=? ke "d") DD]
       [else ER])]
    [(string=? s DD) DD]
    [(string=? s ER) ER]))

(check-expect (key-handler AA "a") BB)
(check-expect (key-handler AA " ") ER)
(check-expect (key-handler BB "b") BB)
(check-expect (key-handler BB "c") BB)
(check-expect (key-handler BB "d") DD)
(check-expect (key-handler BB "z") ER)

(big-bang AA
          [to-draw render]
          [on-key key-handler])

