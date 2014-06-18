;; sicp-2-2.ss: Consider the problem of representing line segments in a plane.
;; Each segment is represented as a pair of points: a starting point and an
;; ending point. Define a constructor make-segment and selectors start-segment
;; and end-segment that define the representation of segments in terms of
;; points Furthermore, a point can be represented as a pair of numbers: the x
;; coordinate and the y coordinate. Accordingly, specify a constructor
;; make-point and selectors x-point and y-point that define this representation
;; Finally, using your selectors and constructors, define a procedure
;; midpoint-segment that takes a line segment as argument and returns its
;; midpoint (the point whose coordinates are the average of the coordinates of
;; the endpoints). To try your procedures, you'll need a way to print points:
(define (print-point p)
  (newline)
  (display  "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

;; return point
(define (make-point x y)
  (cons x y))

;; return x-coordinate value
(define (x-point p)
  (car p))

;; return y-coordinate value
(define (y-point p)
  (cdr p))

;; return line segment
(define (make-segment s e)
  (cons s e))

;; return point
(define (start-segment line)
  (car line))

;; return point
(define (end-segment line)
  (cdr line))

;; return point
(define (midpoint-segment line)
  (make-point (average (x-point (start-segment line))
                       (x-point (end-segment line)))
              (average (y-point (start-segment line))
                       (y-point (end-segment line)))))

(define (average x y)
  (/ (+ x y) 2.0))


;; testing
(define start-point (make-point 1 1))
;;=> '(1 . 1)
(define end-point (make-point 2 3))
;;=> '(2 . 3)
(define test-line (make-segment start-point end-point))
;;=> '((1 . 1) 2 . 3)

(start-segment test-line)
;;=> '(1 . 1)
(end-segment test-line)
;;=> '(2 . 3)
(midpoint-segment test-line)
;;=> '(1.5 . 2.0)
