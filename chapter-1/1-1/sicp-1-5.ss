;; sicp-1-5: compare the behavior of the following two procedures
;; when they're interpreted using applicative-order evaluation vs.
;; normal-order evaluation.
;; (define (p) (p))
;; (define (test x y)
;;   (if (= x 0)
;;       0
;;       y))
;; (test 0 (p))


;; The first procedure simply makes a recursive call to itself. If
;; you evaluate (p) directly, it will never return because each
;; recursive call makes another recursive call with no base case
;; defined.
;; The test procedure is used to determine the evaluation order of
;; the interpreter by running it with the recursive procedure as its
;; second argument.


;; If the interpreter uses applicative-order evaluation, the very first
;; expression the iterpreter sees (test 0 (p)) has one operand and two
;; arguments, all of which will be evaluated. The operand test will
;; evaluate to the body of its procedure, the symbol 0 will evaluate to
;; its value, and the operand (p) will evaluate to a recursive call to
;; itself, which will never stop recursing.
