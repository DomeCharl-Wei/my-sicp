;; sicp-2-43.ss: Louis Reasoner is having a terrible time doing exercise 2.42.
;; His queens procedure seems to work, but it runs extremely slowly. (Louis
;; never does manage to wait long enough for it to solve even the 6*6 case.)
;; When Louis asks Eva Lu Ator for help, she points out that he has
;; interchaged the order of the nested mappings in the flatmap, writing it as
;;
;; (flatmap
;;  (lambda (new-row)
;;    (map (lambda (rest-of-queens)
;;           (adjoin-position new-row k rest-of-queens))
;;         (queen-cols (- k 1))))
;;  (enumerate-interval 1 board-size))
;;
;; Explain why this interchange makes the program run slowly. Estimate how
;; long it will take Louis's porgram to solve

;; this solution takes time T^{board-size} to combine the all positions of
;; kth queen with the rest-of-queens permutations


;; In the original solution, queen-cols is called once for each column in
;; the board. This is an expensive procedure to call, since it generates the
;; sequence of all possible ways to place k queens in k columns. By moving
;; queen-cols so it gets called by flatmap, we're transforming a linear
;; recursive process to a tree-recursive process. The flatmap procedure is
;; called for each row of the kth column, so the new procedure is generating
;; all the possible solutions for the first k-1 columns for each one of these
;; rows.

;; We learned back in section 1.2.2 that a tree-recursive process grows
;; exponentially. If it takes time T to execute the original version of
;; queens for a given board size, we can expect the new version to take
;; roughly T^{board-size} time to execute.
