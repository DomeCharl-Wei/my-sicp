;; sicp 2.1 optimize makr-rat

(define (make-rat n d)
  (let ((g (gcd n d)))
    (cond ((= d 0) (error "denom can not be zero!"))
          ((and (< n 0) (< d 0)) ;; 分子分母都小于0
           (cons (/ (abs n) g)
                 (/ (abs d) g)))
          ((< d 0)               ;; 分子大于0, 分母小于0
           (cons (/ (- 0 n) g)
                 (/ (- 0 d) g)))
          (else (cons (/ n g)    ;; 其他两种情况
                      (/ d g))))))
