;; implement table
(load "/Users/enzo/test/scheme/sicp-utils.ss")

(define (make-table same-key?)
  (let ((local-table (cons '*table* '())))
    ;; procedure assoc
    (define (assoc key records)
      (cond ((null? records) #f)
            ((same-key? key (car (car records))) (car records))
            (else (assoc key (cdr records)))))

    ;; procedure lookup
    (define (lookup key1 key2)
      (let ((subtable (assoc key1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key2 (cdr subtable))))
              (if record
                  (cdr record)
                  #f))
            #f)))

    ;; procedure insert!
    (define (insert! key1 key2 value)
      (let ((subtable (assoc key1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key2 (cdr subtable))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! subtable
                            (cons (cons key2 value)
                                  (cdr subtable)))))
            (set-cdr! local-table
                      (cons (cons key1
                                  (cons (cons key2 value)
                                        '()))
                            (cdr local-table))))
        'ok))

    ;; procedure dispatch
    (define (dispatch m)
      (cond ((eq? m 'lookup) lookup)
            ((eq? m 'insert!) insert!)
            (else (error "Unsupported method" m))))
    dispatch))

(define t (make-table equal?))
(define (lookup key1 key2)
  ((t 'lookup) key1 key2))
(define (insert! key1 key2 value)
  ((t 'insert!) key1 key2 value))

;; test case
(insert! 'letters 'a 97)
(insert! 'letters 'b 98)
(insert! 'math '+ 45)
(insert! 'math '- 47)
(lookup 'letters 'c)
(lookup 'math '+)
