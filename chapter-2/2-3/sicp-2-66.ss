;; sicp-2-66: Implement the lookup procedure for the case where the set of
;; records is structured asa a binary tree, ordered by the numerical valeus
;; of the keys.

(load "sicp-tree-set.ss")

(define (key record)
  (car record))

(define (lookup given-key set-of-records)
  (cond ((null? set-of-records) false)
        ((= given-key (key (entry set-of-recoreds)))
         (entry set-of-records))
        ((< given-key (key (left-branch set-of-records)))
         (left-branch set-of-records))
        ((> given-key (key (right-branch set-of-records)))
         (right-branch set-of-records))))
