;; It's a halting problem!
;; ref: http://www.lel.ed.ac.uk/~gpullum/loopsnoop.html

(define (run-forever) (run-forever))
(define (try p)
  (if (halts? p p)
      (run-forever)
      'halted))

;; if (try try) returns 'halted, expression (halts? p p) is true,
;; so it will run (run-forever); (run-forever) will never return,
;;
;; if (try try) never returned, expression (halts? p p) is false,
;; so it will return 'halted.
