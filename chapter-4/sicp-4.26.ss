;; 将unless转化为if
(require 'scheme)

(define (unless? exp)
  (tagged-list? exp 'unless))

(define (unless-condition exp)
  (cadr exp))

(define (unless-usual-value exp)
  (caddr exp))

(define (unless-exception exp)
  (cadddr exp))

(define (unless->if exp)
  (make-if (unless-condition exp)
	   (unless-exception exp)
	   (unless-usual-value exp)))

;; 在应用序语言中, 把unless表示成过程, 在什么情况下可以使用?
;; 
