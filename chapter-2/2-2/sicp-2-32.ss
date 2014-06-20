;; sicp-2-32.ss: We can represent a set as a list of distinct elements, and we
;; can represent the set of all subsets of the set as a list of lists. For
;; example, if the set is (1 2 3), then the set of all subsets is ((), (3), (2)
;; (2 3) (1) (1 3) (1 2) (1 2 3)). Complete the following definition of
;; procedure that generates the set of subsets of a set and give a clear
;; explanation of why it works:
;;
;; (define (subsets s)
;;   (if (null? s)
;;       (list null)
;;       (let ((rest (subsets (cdr s))))
;;         (append rest (map <??> rest)))))

;; Let's analysis the example above.
;; We divide the list '(1 2 3) first as follows:
;;    '(1 2 3)
;;  1       '(2 3)
;;  1      2    '(3)
;;  1      2    3  '()
;;
;; Then we combine them like this:
;;  1      2    3  '(())
;;  1      2    '((3) ())
;;  1      '((2 3) (2) (3) ())
;;  '((1 2 3) (1 2) (1 3) (1) (2 3) (2) (3) ())
;;
;; So, we can fill the procedure subsets
(define (subsets s)
  (if (null? s)
      (list null)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x)
                            (append (list (car s)) x))
                          rest)))))


;; testing
(subsets '(1 2 3))
;;=> '(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))

(subsets '(1 2 3 4))
;;=> '(()
;;     (4)
;;     (3)
;;     (3 4)
;;     (2)
;;     (2 4)
;;     (2 3)
;;     (2 3 4)
;;     (1)
;;     (1 4)
;;     (1 3)
;;     (1 3 4)
;;     (1 2)
;;     (1 2 4)
;;     (1 2 3)
;;     (1 2 3 4))
