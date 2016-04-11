;; define or-gate
(define (or-gate a1 a2 out)
  (and-gate a1 a2 out)
  (inverter out out))
