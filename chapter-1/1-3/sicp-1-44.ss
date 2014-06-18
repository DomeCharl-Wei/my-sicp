;; sicp-1-44.ss: The idea of smoothing a function is an important concept in
;; signal processing. If f is a function and dx is some small number, then
;; the smoothed version of f is the function whose value at a point x is the
;; average of f(x - dx), f(x), and f(x + dx). Write a procedure smooth that
;; takes as input a procedure that computes f and returns a procedure that
;; computes the smoothed f. It is sometimes valuable to repeatedly smooth
;; a function (that is, smooth the smoothed function, and so on) to obtained
;; the n-fold smoothed function. Show how to generate the n-fold smoothed
;; function of any given function using smooth and repeated from exercise 1.43

(define dx 0.00001)

(define (smoothing f)
  (lambda (x)
    (/ (f (- x dx))
       (f x)
       (f (+ x dx)))))

(define (n-fold-smoothing f n)
  (define (iter c fn)
    (if (> c n)
        fn
        (iter (+ c 1)
              (lambda (x)
                (/ (fn (- x dx))
                   (fn x)
                   (fn (+ x dx)))))))

  (iter 1 f))
