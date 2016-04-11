;; ripple-carry-adder

;; half adder
(define (half-adder a b s c)
  (let ((d (make-wire))
        (e (make-wire)))
    (or-gate a b d)
    (and-gate a b c)
    (inverter c e)
    (and-gate d e s)
    'ok))

;; half-adder-delay = or-gate-delay + and-gate-delay * 2 + inverter-delay

;; full adder
(define (full-adder a b c-in sum c-out)
  (let ((s (make-wire))
        (c1 (make-wire))
        (c2 (make-wire)))
    (half-adder b c-in s c1)
    (half-adder a s sum c2)
    (or-gate c1 c2 c-out)
    'ok))

;; full-adder-delay = half-adder * 2 + or-gate-delay

(define (ripple-carry-adder a-list b-list c-in sum c-out)
  (if (or (null? a-list)
          (null? b-list))
      'ok
      (let ((s 0))
        (full-adder (car a-list)
                    (car b-list)
                    c-in
                    s
                    c-out)
        (ripple-carry-adder (cdr a-list)
                            (cdr b-list)
                            c-out
                            (append sum (list s))
                            c-out))))

;; ripple-carry-adder-delay = length(a-list) * full-adder-delay
