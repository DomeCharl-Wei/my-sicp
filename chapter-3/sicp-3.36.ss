;; Suppose we evaluate the following sequence of expressions in the gobal
;; environment:
;;
;; (define a (make-connector))
;; (define b (make-connector))
;; (set-value! a 10 'user)
;;
;; At some time during evaluation of the set-value!, the following expression
;; from the connector's local procedure is evaluted:
;;
;; (for-each-except setter inform-about-value constraints)
;;
;; Draw an environment diagram showing the environment in which the above
;; expression is evaluated.
