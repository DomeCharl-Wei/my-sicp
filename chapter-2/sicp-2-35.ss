;; sicp-2-35.ss: Redefine count-leaves from section 2.2.2 as an accumulation:
;; (define (count-leaves t)
;;   (accumulate <??> <??> (map <??> <??>)))


(define (accumulate op init seq)
  (if (null? seq)
      init
      (op (car seq)
          (accumulate op init (cdr seq)))))

(define (enumerate-tree t)
  (cond ((null? t) null)
        ((not (pair? (car t))) (cons (car t)
                                     (enumerate-tree (cdr t))))
        (else (append (enumerate-tree (car t))
                      (enumerate-tree (cdr t))))))

(define (count-leaves t)
  (accumulate + 0 (map (lambda (x) (if (pair? x)
                                       0
                                       1))
                       (enumerate-tree t))))
