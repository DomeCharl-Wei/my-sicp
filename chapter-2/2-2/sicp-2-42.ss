;; sicp-2-42.ss: Complete the program by implementing the representation for
;; sets of board positions, including the procedure adjoin-position, which
;; adjoins a new row-column position to a set of positions, and empty-board
;; which represents an empty set of positions. You must also write the
;; procedure safe?, which determines for a set of position, whether the queen
;; in the kth column is safge with respect to the others. (Note that we need
;; only check whether the new queen is safe -- the other queens are already
;; guarateed safe with respect to each other.)

;; The 'eight-queens puzzle' asks how to place eight queens on a chessboard
;; so that no queen is in check from any other (i.e. no two queens are in
;; the same row, column, or diagonal). One possible solution is shown in
;; figure 2.8. One way to solve the puzzle is to work across the board,
;; placing a queen in each column. Once we have placed k-1 queens, we must
;; place the kth queen in a position where it does not check any of the
;; queens already on the board. We can formulate this approach recursively:
;; Assume that we have already generated the sequence of all possible ways
;; to place k-1 queens in the first k-1 columns of the board. For each of
;; these ways, generate an extended set of positions by placing a queen in
;; each row of the kth column. Now filter these, keeping only the positions
;; for which the queen in the kth column is safe with respect to the other
;; queens. This produces the sequence of all ways to place k queens in the
;; first k columns. By continuing this process, we will produce not only one
;; solution, but all solutions to the puzzle

;; returns a sequence of all solutions to the problem of placing n queens
;; on an n*n chessboard.
(define (queens board-size)
  ;; returns the sequence of all ways to place queens in the first k columns
  ;; of the board.
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        ;; filter the not safe combinations
        (filter
         (lambda (positions) (safe? k positions))
         ;; combine current position queen with all kinds of k-1 safe queens
         ;; permutation
         (flatmap
          (lambda (rest-of-queens)
            ;; append all positions of current queen to k-1 safe queens
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

;; position
(define (make-position row col)
  (cons row col))

(define (position-row position)
  (car position))

(define (position-col position)
  (cdr position))

;; adjoin-position
(define empty-board null)

(define (adjoin-position row col positions)
  (append positions (list (make-position row col))))

;; safe?
(define (safe? col positions)
  (let ((kth-queen (list-ref positions (- col 1)))
        (other-queens (filter (lambda (q)
                                (not (= col (position-col q))))
                              positions)))

    (define (abs x)
      (if (< x 0)
          (- 0 x)
          x))

    (define (attacks? q1 q2)
      (or (= (position-row q1) (position-row q2))
          (= (abs (- (position-row q1) (position-row q2)))
             (abs (- (position-col q1) (position-col q2))))))

    (define (iter q board)
      (or (null? board)
          (and (not (attacks? q (car board)))
               (iter q (cdr board)))))

    (iter kth-queen other-queens)))


;; basic procedure
(define (filter fn seq)
  (cond ((null? seq) null)
        ((fn (car seq)) (cons (car seq)
                              (filter fn (cdr seq))))
        (else (filter fn (cdr seq)))))

(define (accumulate op init seq)
  (if (null? seq)
      init
      (op (car seq)
          (accumulate op init (cdr seq)))))

(define (flatmap proc seq)
  (accumulate append null (map proc seq)))


(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low (enumerate-interval (+ low 1) high))))
