;; sicp 2.66 define lookup base on bi-tree
(define (lookup given-key set-of-records)
  (cond ((null? set-of-records) #f)
        ((equal? given-key (key (car set-of-records)))
         (car set-of-records))
        ((< given-key (key (car set-of-records)))
         (lookup given-key (left-branch set-of-records)))
        ((< (key (car set-of-records)) given-key)
         (lookup given-key (right-branch set-of-records)))))
