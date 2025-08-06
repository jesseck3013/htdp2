;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(require 2htdp/abstraction)

(define SIZE 12) ; font size 
(define COLOR "black") ; font color 
(define BT ; a graphical constant 
  (beside (circle 1 'solid 'black) (text " " SIZE COLOR)))
 
; Image -> Image
; marks item with bullet
(check-expect (bulletize (text "example" SIZE 'black))
              (beside/align 'center BT
                            (text "example" SIZE 'black)))
(define (bulletize item)
  (beside/align 'center BT item))
 
; XEnum.v2 -> Image
; renders an XEnum.v2 as an image 
(check-expect
 (render-enum '(ul (li (word ((text "point 1"))))
                   (li (word ((text "point 2"))))
                   ))
 (above/align
  'left
   (render-item '(li (word ((text "point 1")))))
  (above/align
   'left
    (render-item '(li (word ((text "point 2")))))
   empty-image)))


(define (render-enum xe)
  (local ((define content (xexpr-content xe))
          ; XItem.v2 Image -> Image 
          (define (deal-with-one item so-far)
            (above/align 'left (render-item item) so-far)))
    (foldr deal-with-one empty-image content)))
 
; XItem.v2 -> Image
; renders one XItem.v2 as an image
(check-expect (render-item '(li (word ((text "example")))))
              (bulletize
               (text "example" SIZE 'black)))

(check-expect (render-item
               '(li
                 (ul
                  (li (word ((text "part 1"))))
                  (li (word ((text "part 2")))))))
              (bulletize
               (render-enum '(ul
                              (li (word ((text "part 1"))))
                              (li (word ((text "part 2"))))))))

(define (render-item an-item)
  (local ((define content (first (xexpr-content an-item))))
      (cond
        [(word? content)
         (bulletize
          (text (word-text content) SIZE 'black))]
        [else
         (bulletize (render-enum content))])))

; The change works because I made tests for two possible
; outputs. After editting, I can run the tests to confirm
; if the change breaks the program.

; I prefer the second version, it is more easier for me to read.

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
