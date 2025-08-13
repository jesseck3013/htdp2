;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise489) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; [List-of String] -> String
(check-expect (combine-string (list "world" "hello"))
              "hello world")
(check-expect (combine-string '())
              "")

(define (combine-string los)
  (local ((define new-string
            (foldr (lambda (s rst)
                     (string-append s " " rst)) "" (reverse los)))
          (define len (string-length new-string)))
    (if (= len 0)
        new-string
        (substring
         new-string
         0
         (sub1 (string-length new-string))))))

(define (fmt w in-f out-f)
  (local (
           (define file (read-words in-f))

           ; [List-of String] [List-of String] -> String
           (define (fmt/acc left seen)
             (cond
               [(empty? left) (combine-string seen)]
               [(empty? seen) (fmt/acc (rest left) (cons (first left) seen))]
               [else (local (
                             (define one-more-word
                               (cons (first left) seen))
                             (define new-line
                               (combine-string one-more-word))
                             )
                       (if (>= (string-length new-line)
                               w)
                           (string-append (combine-string seen) "\n" (fmt/acc left '()))
                               (fmt/acc (rest left) one-more-word)))]))
           )
    (write-file out-f
                (fmt/acc file '()))))

(fmt 70 "./text" "text-out")

