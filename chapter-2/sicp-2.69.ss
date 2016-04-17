;; sicp 2.69
;; generate huffman tree

(load "huffman.ss")

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge leaf-set)
  (define (help tree remaining-set)
    (if (null? remaining-set)
        tree
        (let ((leaf (car remaining-set)))
          (if (null? tree)
              (help leaf
                    (cdr remaining-set))
              (help (make-code-tree leaf
                                    tree)
                    (cdr remaining-set))))))
  (help '() leaf-set))

(define pairs '((A 4) (C 1) (B 2) (D 1)))
(generate-huffman-tree pairs)
(make-leaf-set pairs)
(successive-merge (make-leaf-set pairs))
