(define (render-rocket height)
  (place-image ROCKET 10 (- height CENTER) BACKG))

;; Single point of contorl is a better design because every time you  update the render logic, you only need to update one expression instead of three.
