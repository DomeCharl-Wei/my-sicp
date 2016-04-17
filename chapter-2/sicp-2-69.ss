;; sicp-2-69: The following procedure takes as its argument a list of symbol-
;; frequency pairs (where no symbol appears in more than one pair) and
;; generates a Huffman encoding tree according to the Huffman algorithm
(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))
;; make-leaf-set is the procedure given above that transforms the list of pairs
;; into an ordered set of leaves.
;; successive-merge is the procedure you must write, using make-code-tree to
;; successively merge the smallest-weight elements of the set until there is
;; only one element left, which is the desired Huffman tree.

(load "sicp-huffman-tree.ss")

(define (make-leaf-set pairs)
  (define (transform remain-pairs set)
    (cond ((null? remain-pairs) set)
          ((null? set) (transform (cdr remain-pairs)
                                 (adjoin-set-weight (car remain-pairs) '())))
          (else (transform (cdr remain-pairs)
                           (adjoin-set-weight (car remain-pairs) set)))))
  (transform pairs '()))

(define (adjoin-set-weight x set)
  (cond ((null? set) (list x))
        ((eq? (symbol-leaf x) (symbol-leaf (car set))) set)
        ((= (weight-leaf x) (weight-leaf (car set))) (cons x set))
        ((> (weight-leaf x) (weight-leaf (car set))) (cons (car set)
                                                           (adjoin-set-weight x (cdr set))))
        ((< (weight-leaf x) (weight-leaf (car set))) (cons x set))))

(define (successive-merge set)
  (define (construct remain-set code-tree)
    (if (null? remain-set)
        code-tree
        (construct (cdr remain-set)
                   (make-code-tree (car remain-set) code-tree))))

  (cond ((null? set) '())
        ((null? (cdr set)) set)
        (else (construct (cdr set) (car set)))))
