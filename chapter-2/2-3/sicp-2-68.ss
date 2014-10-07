;; sicp-2-68: The encode procedure takes as arguments a message and a tree and
;; produces the list of bits that gives encoded message.
;; (define (encode message tree)
;;   (if (null? message)
;;       '()
;;       (append (encode-symbol (car message) tree)
;;               (encode (cdr message) tree))))
;; Encode-symbol is a procedure, which you must write, that returns the list of
;; bits that encodes a given symbol according to a given tree. You should
;; design encode-symbol so that it signals an error if the symbol is not in the
;; tree at all. Test your procedure by encoding the result you obtained in
;; exercise 2.67 with the sample tree and seeing whether it is the same as the
;; original sample message.

(load "sicp-huffman-tree.ss")
(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (symbol-eq? symbol leaf)
  (eq? symbol (symbol-leaf leaf)))


(define (encode-symbol symbol tree)
  (define (encoding remain-tree result)
    (cond ((leaf? remain-tree)
           (if (symbol-eq? symbol remain-tree)
               result
               (error "Error in Encoding" symbol)))
          ((symbol-eq? symbol (left-branch remain-tree))
           (append result '(0)))
          (else (encoding (right-branch remain-tree)
                          (append result '(1))))))
  (encoding tree '()))

;; for testing
;; (encode '(A D A B B C A)
;;         '((leaf A 4)
;;           ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
;;           (A B D C)
;;           8))
;; result:
;; '(0 1 1 0 0 1 0 1 0 1 1 1 0)
