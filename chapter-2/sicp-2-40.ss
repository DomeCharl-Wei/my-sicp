;; sicp-2-40.ss: Define procedure unique-pairs that, given an integer n,
;; generates the sequence of pairs (i, j) with 1<=j<=i<=n. Use unique-pairs
;; to simplify the definition of prime-sum-pairs given above.

(define (unique-pairs n)
  (flatmap (lambda (i)
             (map (lambda (j) (list i j))
                  (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))

(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

(define (accumulate op init seq)
  (if (null? seq)
      init
      (op (car seq)
          (accumulate op init (cdr seq)))))

(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low (enumerate-interval (+ low 1) high))))


(define (prime-sum-pairs n)
  (map make-pairs (filter sum-prime? (unique-pairs n))))

(define (make-pairs pair)
  (let ((first (car pair))
        (second (cadr pair)))
    (list first second (+ first second))))

(define (sum-prime? pair)
  (let ((first (car pair))
        (second (cadr pair)))
    (prime? (+ first second))))

(define (filter fn seq)
  (cond ((null? seq) null)
        ((fn (car seq)) (cons (car seq)
                              (filter fn (cdr seq))))
        (else (filter fn (cdr seq)))))

(define (prime? n)
  (= (smallest-divisor n) n))

(define (smallest-divisor n)
  (define (iter test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (iter (+ test-divisor 1)))))
  (iter 2))

(define (divides? a b)
  (= (remainder b a) 0))

(define (square x) (* x x))

;; testing
(prime-sum-pairs 6)
;;=> '((2 1 3) (3 2 5) (4 1 5) (4 3 7) (5 2 7) (6 1 7) (6 5 7))
