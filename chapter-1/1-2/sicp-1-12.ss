;;; sicp 1-12

;;; recursively
;;; if col = 1, the value is 1
;;; if row = col, the value is 1
;;; else the value is p(row-1, col-1) + p(row-1, col)
(define (pascal row col)
  (cond ((< row col) 0)
        ((= col 1) 1)
        ((= row col) 1)
        (else (+ (pascal (- row 1) (- col 1))
                 (pascal (- row 1) col)))))
