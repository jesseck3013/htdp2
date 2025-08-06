;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(require 2htdp/abstraction)

; Xexpr.v2 -> [List-of Attribute]
; retrieves the list of attributes of xe
(define (xexpr-attr xe)
  (local ((define optional-loa+content (rest xe)))
    (cond
      [(empty? optional-loa+content) '()]
      [else
       (local ((define loa-or-x
                 (first optional-loa+content)))
         (if (list-of-attributes? loa-or-x)
             loa-or-x
             '()))])))

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
(define l5 '(li (word ((text "bye")))))

(define u1 `(ul ,l1 ,l2 ,l4))
(define u1-bye `(ul ,l1 ,l2 ,l5))

(define u2 `(ul ,l1 ,l2 ,l3))

(define u3 '(ul))

(define u4 `(ul
             (li ,u1)
             (li ,u2)
             (li (word ((text "part 3"))))))
(define u4-bye `(ul
             (li ,u1-bye)
             (li ,u2)
             (li (word ((text "part 3"))))))

(define u5 `(ul ,l4 ,l4 ,l4 ,l4 ,l4))
(define u5-bye `(ul ,l5 ,l5 ,l5 ,l5 ,l5))

(define u6 `(ul
             (li ,u5)))
(define u6-bye `(ul
                 (li ,u5-bye)))

; XEnum.v2 -> Number
; Count the number of all occurrences of "hello" in
; a given XEnum.v2
(check-expect (replace-hello u1) u1-bye)
(check-expect (replace-hello u2) u2)
(check-expect (replace-hello u3) u3)
(check-expect (replace-hello u4) u4-bye)
(check-expect (replace-hello u5) u5-bye)
(check-expect (replace-hello u6) u6-bye)

(define (replace-hello xe)
  (local (
          (define items (xexpr-content xe))
          (define attributes (xexpr-attr xe))
          )
    (if (empty? attributes)
        (cons 'ul (map replace-hello-item items))
        (cons 'ul
              (cons 
              attributes
              (map replace-hello-item items))))
    ))

; XItem.v2 -> Number
(check-expect (replace-hello-item l4) l5)
(check-expect (replace-hello-item `(li ,u3)) `(li ,u3))

(define (replace-hello-item item)
  (local (
          (define content (first (xexpr-content item)))
          (define attributes (xexpr-attr item))
          )
    (cond 
      [(word? content)
       (if (equal? (word-text content) "hello")
           (if (empty? attributes)
               '(li (word ((text "bye"))))
               `(li ,attributes (word ((text "bye")))))
           item)]
      [else
       (local (
               (define replaced-content
                 (map replace-hello (xexpr-content item)))
               )
         (if (empty? attributes)
             `(li ,@replaced-content)
             `(li ,attributes ,@replaced-content)))])))
        

