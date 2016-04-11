;; sicp-2-45.ss: Right-split and up-split can be expressed as instances of a
;; general splitting operation. Define a procedure split with the property
;; that evaluating
;;
;; (define right-split (split beside below))
;; (define up-split (split below beside))
;;
;; produces procedures right-split and up-split with the same behaviour as the
;; ones already defined.

(define (split combine cut)
  (lambda (painter)
    (combine painter (cut painter painter))))

;; testing
(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

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

(define right-split (split beside below))
(define up-split (split below beside))

(paint (right-split wave))
;;=> [image]

(paint (up-split wave))
;;=> [image]
