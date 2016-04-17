;; sicp-2-49.ss: Use segments-painter to define the following primitive
;; painters:
(load "sicp-2-47.ss")
(load "sicp-2-48.ss")

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))

(define (base frame) (origin frame))
(define (right frame) (add-vect (base frame) (edge1-frame frame)))
(define (left frame) (add-vect (base frame) (edge2-frame frame)))
(define (top frame) (add-vect (right frame) (edge2-frame frame)))

;; a. The painter that draws the outline of the designated frame
(define (frame-painter frame)
  (let ((b (make-segment (base frame) (right frame)))
        (l (make-segment (base frame) (left frame)))
        (t (make-segment (left frame) (top frame)))
        (r (make-segment (rihgt frame) (top frame))))
    ((segments-painter (list b l t r)) frame)))

;; b. The painter that draws an "X" by connecting opposite corners of the
;; frame.
(define (x-painter frame)
  (let ((h (make-segment (left frame) (right frame)))
        (v (make-segment (base frame) (top frame))))
    ((segments-painter (list h v)) frame)))

;; c. The painter that draws a diamond shape by connecting the midpoints of
;; the sides of the frame.
(define (middle-painter frame)
  (let ((b (/ (add-vect (base frame) (right frame)) 2))
        (l (/ (add-vect (base frame) (left frame)) 2))
        (t (/ (add-vect (left frame) (top frame)) 2))
        (r (/ (add-vect (right frame) (top frame)) 2)))
    ((segments-painter (list (make-segment b r)
                             (make-segment b l)
                             (make-segment l t)
                             (make-segment r t)))
     frame)))
