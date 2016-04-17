(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

;; a). left-branch, right-branch, branch-length, branch-structure
(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cadr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cadr branch))


;; b). define total-weight
(define (total-weight mobile)
  (cond ((null? mobile) 0)
        ((pair? (branch-structure (left-branch mobile)))
         (+ (total-weight (branch-structure (left-branch mobile)))
            (total-weight (branch-structure (right-branch mobile)))))
        (else (+ (branch-structure (left-branch mobile))
                 (total-weight (branch-structure (right-branch mobile)))))))

(define (branch-weight branch)
  (if (pair? (branch-structure branch))
      (total-weight (branch-structure branch))
      (branch-structure branch)))

(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

;; c). branch torque
(define (branch-lg branch)
  (* (branch-length branch)
     (branch-weight branch)))

(define (branch-balanced? branch)
  (if (pair? (branch-structure branch))
      (balanced? (branch-structure branch))
      #t))

(define (balanced? mobile)
  (and (= (branch-lg (left-branch mobile))
          (branch-lg (right-branch mobile)))
       (branch-balanced? (left-branch mobile))
       (branch-balanced? (right-branch mobile))))
