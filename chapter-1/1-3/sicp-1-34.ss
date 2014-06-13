;; sicp-1-34.ss: Suppose we define the procedure
;; (define (f g)
;;   (g 2))
;; Then we have
;; (f square)
;; 4
;; (f (lambda (z) (* z (+ z 1))))
;; 6
;; What happens if we (perversely) ask the interpreter to evaluate the
;; combination (f f)? Explain.


(define (f g)
  (g 2))


(f f)
;; What the interpreter output is as follows:
;; => application: not a procedure;
;; => expected a procedure that can be applied to arguments
;; => given: 2
;; => arguments...:
;; => 2
;; => errortrace...:
;; => stdin::106956: (g (quote 2))
;; => context...:
;; => /usr/share/racket/collects/racket/private/misc.rkt:87:7

;; The procedure f expected a procedure which has an argument. And the
;; argument must be a integer not procedure.
