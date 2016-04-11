;; any key

(define (make-table)
  (let ((local-table (list '*table*)))
    ;; procedure assco
    (define (assoc key records)
      (cond ((null? records) #f)
            ((equal? key (caar records)) (car records))
            (else (assoc key (cdr records)))))
    ;; procedure lookup
    (define (_lookup keys table)
      (cond ((null? table) #f)
            ((null? keys) table)
            (else
             (let ((record (assoc (car keys) (cdr table))))
               (if record
                   (_lookup (cdr keys) record)
                   #f)))))
    (define (lookup .keys)
      (_lookup keys local-table))

    ;; procedure insert!
    (define (_insert! keys value table)
      )
    ))
