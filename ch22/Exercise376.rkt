;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(require 2htdp/abstraction)

(define (xexpr-content xe)
  (local (
          (define optional-loa+content (rest xe))
          ; output is one of:
          ; - '()
          ; - Xexpr.v2
          ; - (cons [list-of-attributes] Xexpr.v2)

          ; [list-of-attributes] or Xexpr.v2 -> Boolean
          (define (content? x)
            (cond
              [(empty? x) #false]
              [else (local (
                            (define loa-or-x (first x))
                            )
                      (symbol? loa-or-x))]))

          (define get-content
            (cond
              [(empty? optional-loa+content)
               '()]
              [else (local (
                            (define attributes-or-x
                              (first optional-loa+content))
                            )
                      (if (content? attributes-or-x)
                          optional-loa+content
                          (rest optional-loa+content)))]))
          ) 
  get-content))

(define (word? value)
  (cond
    [(atom? value) #false]
    [(empty? value) #false]
    [(empty? (rest value)) #false]
    [(not
      (list-of-attributes? (second value)))
     #false]
    [else (and
           (equal? (first value) 'word)
           (string? (find-attr
                     (second value) 'text)))]))

(define (word-text w)
  (local ((define attributes (second w)))
    (find-attr attributes 'text)))

; ISL+ value -> Boolean
(define (atom? value)
  (not (cons? value)))

; [List-of Attribute] or Xexpr.v2 -> Boolean
; is x a list of attributes
(define (list-of-attributes? x)
  (cond
    [(empty? x) #true]
    [else
     (local ((define possible-attribute (first x)))
       (cons? possible-attribute))]))

; [List-of Attribute] Symbol -> [Maybe String]
(define (find-attr loa s)
  (cond
    [(empty? loa) #false]
    [else
     (local
         (
          (define attr
            (first loa))

          (define attr-name
            (first attr))

          (define attr-value
            (second attr))
          )
       (if (equal? attr-name s)
           attr-value
           (find-attr (rest loa) s)))]))

(define l1 '(li (word ((text "part 1")))))
(define l2 '(li (word ((text "part 2")))))
(define l3 '(li (word ((text "part 3")))))
(define l4 '(li (word ((text "hello")))))

(define u1 `(ul ,l1 ,l2 ,l4))

(define u2 `(ul ,l1 ,l2 ,l3))

(define u3 '(ul))

(define u4 `(ul
             (li ,u1)
             (li ,u2)
             (li (word ((text "part 3"))))))

(define u5 `(ul ,l4 ,l4 ,l4 ,l4 ,l4))
(define u6 `(ul
             (li ,u5)))

; XEnum.v2 -> Number
; Count the number of all occurrences of "hello" in
; a given XEnum.v2
(check-expect (count-hello u1) 1)
(check-expect (count-hello u2) 0)
(check-expect (count-hello u3) 0)
(check-expect (count-hello u4) 1)
(check-expect (count-hello u5) 5)
(check-expect (count-hello u6) 5)

(define (count-hello xe)
  (local (
          (define items (xexpr-content xe))
          (define deal-with-one
            (lambda (item rst)
              (+ (count-hello-item item)
                 rst)))
          )
    (foldr deal-with-one 0 items)))

; XItem.v2 -> Number
(check-expect (count-hello-item l4) 1)
(define (count-hello-item items)
  (local (
          (define content (first (xexpr-content items)))
          )
    (cond
      [(word? content) (if (equal? (word-text content) "hello")
                           1
                           0)]
      [else (count-hello content)])))
