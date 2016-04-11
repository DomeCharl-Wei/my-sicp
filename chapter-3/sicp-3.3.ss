;; implement make-account with secret
(define (make-account balance passwd)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient amount"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch secret m)
    (if (not (eq? secret passwd))
        (lambda (x) "Incorrect password")
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else (error "Unkown request -- MAKE-ACCOUNT" m)))))
  dispatch)


;; unit test
(define acc (make-account 100 'testpasswd))
((acc 'testpasswd 'withdraw) 40)
((acc 'test 'deposit) 5)
