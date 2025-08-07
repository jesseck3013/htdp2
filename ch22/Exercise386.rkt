;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |22.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; Xexpr.v3 String -> String
; retrieves the value of the "content" attribute 
; from a 'meta element that has attribute "itemprop"
; with value s
(check-expect
  (get '(meta ((content "+1") (itemprop "F"))) "F")
  "+1")

(check-error
  (get '(meta ((content "+1") (itemprop "F"))) "D"))
 
(define (get x s)
  (local ((define result (get-xexpr x s)))
    (if (string? result)
        result
        (error "not found"))))

; An Xexpr.v3 is one of:
;  – Symbol
;  – String
;  – Number
;  – (cons Symbol (cons Attribute*.v3 [List-of Xexpr.v3]))
;  – (cons Symbol [List-of Xexpr.v3])
; 
; An Attribute*.v3 is a [List-of Attribute.v3].
;   
; An Attribute.v3 is a list of two items:
;   (list Symbol String)

; Xexpr.v3 String -> [Maybe String]
(check-expect (get-xexpr 10 'x) #false)
(check-expect (get-xexpr 'x 'x) #false)
(check-expect (get-xexpr "x" 'x) #false)
(check-expect (get-xexpr '(meta ((content "xx") (itemprop "f"))) "f") "xx")
(check-expect (get-xexpr '(html
                           (meta ((content "xx") (itemprop "f")))) "f") "xx")
(check-expect (get-xexpr '(html
                           (meta ((content "yy") (itemprop "x")))
                           (meta ((content "zz") (itemprop "y")))
                           (meta ((content "xx") (itemprop "f")))) "f") "xx")
(check-expect (get-xexpr '(html
                           (meta ((content "yy") (itemprop "x")))
                           (meta ((content "zz") (itemprop "y")))
                           (meta ((content "xx") (itemprop "z")))) "f") #false)

(define (get-xexpr x s)
  (cond
    [(symbol? x) #false]
    [(string? x) #false]
    [(number? x) #false]
    [else
     (local (
             (define tag (first x))
             (define attributes (xexpr-attr x))
             (define content (xexpr-content x))

             ; find itemprop
             (define itemprop (find-attr
                               attributes 'itemprop))

             ; [List-of Xexpr.v3] -> [Maybe String]
             (define (get-xexpr-list xl)
               (cond
                 [(empty? xl) #false]
                 [else
                  (local (
                          (define result-of-first
                            (get-xexpr (first xl) s))
                          )
                    (if (false? result-of-first)
                        (get-xexpr-list (rest xl))
                        result-of-first))]))
             )
       (cond
         [(and
           (equal? tag 'meta)
           (equal? itemprop s))
          (find-attr attributes 'content)]
         [else (get-xexpr-list content)]))]))

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

; [List-of Attribute] or Xexpr.v2 -> Boolean
; is x a list of attributes
(define (list-of-attributes? x)
  (cond
    [(empty? x) #true]
    [else
     (local ((define possible-attribute (first x)))
       (cons? possible-attribute))]))

