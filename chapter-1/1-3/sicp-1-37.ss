;; sicp-1-37.ss: a. An infinite continued fraction is an expression of the form
;; f = \frac{N_1}{D_1 + frac{N_2}{D_2 + \frac{N_3}{D_3 + ...}}}
;; As an example, one can show that the infinite continued fraction expansion
;; with the N_i and the D_i all equal to 1 procedure 1/\phi, where \phi is the
;; golden ratio. One way to approximate an infinite continued fraction is to
;; truncate the expansion after a given number of terms. Such a truncation --
;; a so-called k-term finite continued fraction -- has the form
;; \frac{N_1}{D_1 + \frac{N_2}{.. + \frac{N_k}{D_k}}}
;; Suppose that n and d are procedures of one argument (the term index i) that
;; return the N_i and D_i of the terms of the continued fraction. Define a
;; procedure cont-frac such that evaluating (cont-fact n d k) computes the
;; value of the k-term finite continued fraction. Check your procedure by
;; approximating 1/\phi using
;; (cont-frac (lambda (i) 1.0)
;;            (lambda (i) 1.0)
;;            k)
;; for successive values of k. How large must you make k in order to get an
;; approximation that is accurate to 4 decimal places?
;;
;; b. If your cont-frac procedure generates a recursive process, write one
;; that generates an iterative process. If it generates an iterative process,
;; write one that generates a recursive process.

;; the recursive formula of cont-frac
;; f_{k-1} = D_{k-1} + \frac{N_k}{f_k}
;; f_{n} = \frac{N_n}{D_n}

(define (cont-frac n d k)
  (define (cont-frac-recur i)
    (if (= i k)
        (/ (n k) (d k))
        (+ (d i) (/ (n (+ i 1))
                    (cont-frac-recur (+ i 1))))))
  (/ (n 1) (cont-frac-recur 1)))

(define (cont-frac-iter n d k)
  (define (iter i result)
    (if (= i 0)
        result
        (iter (- i 1)
              (+ (d i) (/ (n (+ i 1)) result)))))

  (/ (n 1) (iter (- k 1) (d k))))


;; calculate golden ratio by fixed-point procedure
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? x y)
    (< (abs (- x y)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (phi)
  (fixed-point (lambda (x) (+ 1 (/ 1.0 x)))
               1.0))

;; approximate-phi
(define (approximate-phi k)
  (/ 1.0 (cont-frac-iter (lambda (i) 1.0)
                         (lambda (i) 1.0)
                         k)))


;; calculate k in order to get an approximation golden ratio that is accurate
;; to 4 decimal places
(define (guess-k first-guess)
  (define tolerance 0.0001)
  (define target (phi))
  (define (abs x)
    (if (< x 0)
        (- 0 x)
        x))
  (define (close-enough? x y)
    (< (abs (- x y)) tolerance))

  (define (iter guess)
    (let* ((next (approximate-phi guess)))
      (if (close-enough? next target)
          guess
          (iter (+ guess 1)))))

  (iter first-guess))

(guess-k 1)
;;=> 11
