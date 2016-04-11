;; Ben Bitdiddle tells Louis that one way to avoid the trouble in exercise 3.34
;; is to define a squarer as a new primitive constraint. Fill in the missing
;; portions in Ben's outline for procedure to implement such a constraint:

(load "/Users/enzo/test/scheme/constraint.ss")
(define (squarer a b)
  (define (process-new-value)
    (if (has-value? b)
        (if (< (get-value b) 0)
            (error "square less than 0 -- SQUARER" (get-value b))
            (set-value! a
                        (sqrt (get-value b))
                        me))
        (cond ((has-value? a)
               (set-value! b
                           (* (get-value a)
                              (get-value a))
                           me)))))
  (define (process-forget-value)
    (forget-value! a me)
    (forget-value! b me)
    (process-new-value))
  (define (me request)
    (cond ((eq? request 'I-have-a-value)
           (process-new-value))
          ((eq? request 'I-lost-my-value)
           (process-forget-value))
          (else
           (error "Unknow request -- SQUARER" request))))
  (connect a me)
  (connect b me)
  me)


(define a (make-connector))
(define b (make-connector))
(define s (squarer a b))
(probe 'A a)
(probe 'B b)

(forget-value! a 'user)
(forget-value! b 'user)
(set-value! a 2 'user)

(forget-value! a 'user)
(forget-value! b 'user)
(set-value! b 4 'user)
