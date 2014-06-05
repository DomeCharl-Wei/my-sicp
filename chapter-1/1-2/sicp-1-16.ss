;;; Design a procedure that evolves an iterative exponentiation process that use succssive squaring and uses a logarithmic number of steps, as does fast-expt. Hint: Using the observation that (b^{n/2})^2  = (b^2)^(n/2), keep, along with the exponent n and the base b, an additional state variable c, and define the state transformation in such a way that the product b_n is unchanged from state to state. At the beginning of the process c is taken to be 1, and the answer is given by the value of c at the end of the process. In general, the technique of defining an invariant an invariant quantity that remains unchanged from state to state is a powerful way to think about the design of iterative algorithms

;;; Note the transformation from state to state
;;; for instance,   2^10
;;;              => 1 * (2^2)^5
;;;              => 1 * 4^5
;;;              => 4 * 4^4
;;;              => 4 * (4^2)^2
;;;              => 4 * 16^2
;;;              => 4 * 256
;;;              => 1024

(define (expt b n)
  (define (even? x)
    (= (remainder x 2) 0))
  (define (square x) (* x x))
  (define (expt-iter base remain product)
    (cond ((= remain 0) product)
          ((even? remain) (expt-iter (square base)
                                     (/ remain 2)
                                     product))
          (else (expt-iter base
                           (- remain 1)
                           (* product base)))))
  (expt-iter b n 1))
