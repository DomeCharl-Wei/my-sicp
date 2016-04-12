;; It's a halting problem!
;; refers:
;;  1. http://www.lel.ed.ac.uk/~gpullum/loopsnoop.html
;;  2. http://blog.csdn.net/pongba/article/details/1336028
;;  3. http://stackoverflow.com/questions/8394455/how-does-this-proof-that-the-halting-problem-is-undecidable-work

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
