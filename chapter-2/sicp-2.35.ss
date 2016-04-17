;; define count-leaves

(load "sicp-utils.ss")


(define (count-leaves t)
  (cond ((null? t) 0)
        ((not (pair? t)) 1)
        (else (+ (count-leaves (car t))
                 (count-leaves (cdr t))))))

(define (accumulate op initial seq)
  (if (null? seq)
      initial
      (op (car seq)
          (accumulate op initial (cdr seq)))))

(define (map func seq)
  (if (null? seq)
      '()
      (cons (func (car seq))
            (map func (cdr seq)))))

(define (count-leaves t)
  (accumulate +
              0
              (map (lambda (x) 1)
                   (fringe t))))

(count-leaves '(1 (2 (3 4)) 5))
