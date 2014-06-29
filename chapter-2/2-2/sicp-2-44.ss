;; sicp-2-44.ss: Define the procedure up-split used by corner-split. It is
;; similar to right-split, except that it switches the roles of below and
;; beside
(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))


;; testing
(define (make-seg a b c d)
  (make-segment (make-vect a b)
                (make-vect c d)))
(define wave (segments->painter (list (make-seg 0.4 0 0.5 0.3)
                                      (make-seg 0.6 0.3 0.6 0)
                                      (make-seg 0.8 0 0.6 0.5)
                                      (make-seg 0.6 0.5 1 0.5)
                                      (make-seg 0.6 0.7 1 0.7)
                                      (make-seg 0.6 0.7 0.6 1)
                                      (make-seg 0.4 1 0.4 0.7)
                                      (make-seg 0.4 0.7 0.2 0.7)
                                      (make-seg 0.2 0.7 0.2 1)
                                      (make-seg 0 1 0 0.5)
                                      (make-seg 0 0.5 0.4 0.5)
                                      (make-seg 0.4 0.5 0.2 0))))
(paint (up-split wave 4))
;;=> [image]
