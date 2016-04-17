;; sicp 2.40

(load "sicp-utils.ss")
(define (unique-pair n)
  (flatmap (lambda (i)
             (map (lambda (j) (list i j))
                  (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))
