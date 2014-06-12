;; sicp-1-32.ss: a. Show that sum and product (sicp-1-31.ss) are both special
;; cases of a still more general notion called accumulate that combines a
;; collection of terms, using some general accumulation function:
;;  (accumulate combiner null-value term a next b)
;; Accumulate takes as arguments the same term and range specifications as sum
;; and product, together with a combiner procedure (of two arguments) that
;; specifies how the current term is to be combined with the accumulation of
;; then preceding terms and a null-value that specifies what base value to use
;; when the terms run out. Write accumulate and show how sum and product can
;; both be defined as simple calls to accumulate.

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))

  (iter a 0))

(define (product tern a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))

  (iter a 1))

(define (sum-combiner x y)
  (+ x y))

(define (prod-combiner x y)
  (* x y))

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (accumulate combiner
                  (combiner null-value (term a))
                  term
                  (next a)
                  next
                  b)))


;; b. If your accumulate procedure generates a recursive process, write one
;; that generates an iterative process. If it generates an iterative process,
;; write one that generates a recursive process.

;; iterative accumulate
(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a)
              (combiner (term a) result))))

  (iter a null-value))
