;; sicp 3.21

(load "/Users/enzo/test/scheme/sicp-utils.ss")

(define q1 (make-queue))
(insert-queue! q1 'a)
(insert-queue! q1 'b)
(delete-queue! q1)
(delete-queue! q1)
(empty-queue? q1)
(car (rear-ptr q1))
