;; sicp-1-26.ss: Explain the expmod as follows:
;; (define (expmod base exp m)
;;   (cond ((= exp 0) 1)
;;         ((even? exp)
;;          (remainder (* (expmod base (/ exp 2) m)
;;                        (expmod base (/ exp 2) m))
;;                     m))
;;         (else
;;          (remainder (* base (expmod base (- exp 1) m))
;;                     m))))

(define (even? n)
  (= (remainder n 2) 0))

(define (square n) (* n n))

(define (expmod-louis base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))


(define step 0)

;; count the steps expmod takes
(define (expmod-normal-with-step base exp m)
  (set! step (+ step 1))
  (cond ((= exp 0) 1)
        (else
         (remainder (* base (expmod-normal-with-step base (- exp 1) m)) m))))

(define (expmod-louis-with-step base exp m)
  (set! step (+ step 1))
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod-louis-with-step base (/ exp 2) m)
                       (expmod-louis-with-step base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod-louis-with-step base (- exp 1) m))
                    m))))


(define (expmod-with-step base exp m)
  (set! step (+ step 1))
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod-with-step base (/ exp 2) m)) m))
        (else
         (remainder (* base (expmod-with-step base (- exp 1) m)) m))))


(define (count-steps fn . rest)
  (set! step 0)
  (apply fn rest)
  (printf "steps: ~a\n" step))


(let* ((prime 1009)
      (random-number (random prime)))
  (printf "(expmod-normal-with-step ~a ~a ~a) takes " random-number prime prime)
  (count-steps expmod-normal-with-step random-number prime prime)
  (printf "(expmod-louis-with-step ~a ~a ~a) takes " random-number prime prime)
  (count-steps expmod-louis-with-step random-number prime prime)
  (printf "(expmod-with-step ~a ~a ~a) takes " random-number prime prime)
  (count-steps expmod-with-step random-number prime prime))


;; let study how many steps even? branch and else branch take
(define step-total 0)
(define step-even 0)
(define step-else 0)
(define (expmod-louis-with-steps base exp m)
  (set! step-total (+ step-total 1))
  (cond ((= exp 0) 1)
        ((even? exp)
         (even?-branch base exp m))
        (else
         (else-branch base exp m))))

(define (even?-branch base exp m)
  (set! step-even (+ step-even 2))
  (remainder (* (expmod-louis-with-steps base (/ exp 2) m)
                (expmod-louis-with-steps base (/ exp 2) m)) m))

(define (else-branch base exp m)
  (set! step-else (+ step-else 1))
  (remainder (* base (expmod-louis-with-steps base (- exp 1) m)) m))

(let* ((prime 1009)
       (random-number (random prime)))
  (newline)
  (printf "(expmod-louis-with-steps ~a ~a ~a)\n" random-number prime prime)
  (expmod-louis-with-steps random-number prime prime)
  (printf "total steps: ~a\neven-branch steps: ~a\nelse-branch steps: ~a\n" step-total step-even step-else))
