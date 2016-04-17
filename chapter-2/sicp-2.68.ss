;; sicp 2.68

(load "huffman.ss")

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (let ((left (left-branch tree))
        (right (right-branch tree)))
    (cond ((eq? (symbol-leaf left) symbol) (list 0))
          ((not (leaf? right)) (cons 1 (encode-symbol symbol right)))
          ((and (leaf? right)
                (eq? (symbol-leaf right) symbol)) (list 1))
          (else (error "can encode symbole" symbol)))))


(define t (make-code-tree
           (make-leaf 'A 4)
           (make-code-tree
            (make-leaf 'B 2)
            (make-code-tree
             (make-leaf 'D 1)
             (make-leaf 'C 1)))))

(encode '(A B C D) t)

(encode-symbol 'E t)
