;; sicp-2-3.ss: Implement a representation for rectangle in a plane. (Hint: You
;; may want to make use of exerice 2.2) In terms of your constructors and
;; selectors, create procedures that compute the perimeter and the area of a
;; given rectangle. Now implement a different representation for rectangles.
;; Can you design your system with suitable abstraction barries, so that the
;; same perimeter and area procedures will work using either representation?

;; define point
(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

;; define segment
(define (make-segment s e)
  (cons s e))

(define (start-segment line)
  (car line))

(define (end-segment line)
  (cdr line))

(define (length-segment line)
  (sqrt (+
         (square (- (x-point (start-segment line))
                    (x-point (end-segment line))))
         (square (- (y-point (start-segment line))
                    (y-point (end-segment line)))))))

(define (square x) (* x x))

(define (sqrt x)
  (define tolerance 0.000001)
  (define (average-damp f)
    (lambda (x) (average x (f x))))
  (define (close-enough? x y)
    (< (abs (- x y)) tolerance))
  (define (average x y)
    (/ (+ x y) 2.0))
  (define (abs x)
    (if (< x 0)
        (- 0 x)
        x))
  (define (improve guess)
    ((average-damp (lambda (y) (/ x y))) guess))
  (define (try guess)
    (let ((next (improve guess)))
      (if (close-enough? guess next)
          guess
          (try next))))
  (try 1.0))

(define (make-rectangle first-point second-point third-point forth-point)
  (cons first-point
        (cons second-point
              (cons third-point
                    forth-point))))

(define (first-point r)
  (car r))

(define (second-point r)
  (car (cdr r)))

(define (third-point r)
  (car (cdr (cdr r))))

(define (forth-point r)
  (cdr (cdr (cdr r))))

(define (length-rectangle r)
  (length-segment (make-segment (first-point r)
                                (second-point r))))

(define (board-rectangle r)
  (length-segment (make-segment (second-point r)
                                (third-point r))))

(define (perimeter r)
  (* (+ (length-rectangle r)
        (board-rectangle r))
     2.0))

(define (area r)
  (* (length-rectangle r)
     (board-rectangle r)))
