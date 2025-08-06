;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(require 2htdp/abstraction)

; An XEnum.v1 is one of: 
; – (cons 'ul [List-of XItem.v1])
; – (cons 'ul (cons Attributes [List-of XItem.v1]))
; An XItem.v1 is one of:
; – (cons 'li (cons XWord '()))
; – (cons 'li (cons Attributes (cons XWord '())))

; An XWord is '(word ((text String))).

(define BT (circle 2 "solid" "black"))

; XItem.v1 -> Image
; Render a bullet point BT on the left of the XItem.v1
(define (render-item1 i)
  (local ((define content (xexpr-content i))
          (define element (first content))
          (define a-word (word-text element))
          (define item (text a-word 12 'black)))
    (beside/align 'center BT item)))

(check-expect
 (render-item1 '(li (word ((text "what")))))
               (beside/align 'center BT
                             (text "what" 12 'black)))

; Xexpr.v2 -> Xexpr.v2
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

; Word -> String
(define (word-text w)
  (local ((define attributes (second w)))
    (find-attr attributes 'text)))

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

