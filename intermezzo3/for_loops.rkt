#lang racket

(define width 2)

(for/list ([width 3] [height width])
  (list width height))

;; (for/list ([width 3] [height 2])
;;   (list width height))

(for*/list ([width 3][height width])
    (list width height))

(for/list ([width 3])
  (for/list ([height width])
    (list width height)))

(list (list 1 0)
      (list 2 0)
      (list 2 1))

