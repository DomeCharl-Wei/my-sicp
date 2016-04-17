(load "sicp-2.51.ss")
;; define procedure below like beside
(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-bottom
           (transform-painter painter1
                              (make-vect 0.0 0.0)
                              (make-vect 1.0 0.0)
                              split-point))
          (paint-top
           (transform-painter painter2
                              split-point
                              (make-vect 1.0 0.5)
                              (make-vect 0.0 1.0))))
      (lambda (frame)
        (paint-bottom frame)
        (paint-top frame)))))


;; define procedure below by beside and rotate
(define (below painter1 painter2)
  (lambda (frame)
    (rotate90 (beside (rotate270 painter1)
                      (rotate270 painter2)))))
