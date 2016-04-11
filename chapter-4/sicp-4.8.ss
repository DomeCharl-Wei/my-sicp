;; sicp 4.8
(require 'scheme)
(require 'sicp-4.6)

;; 命名let
;;  使let支持如下格式:
;;   (let <var> <bindings> <body>)
;;   其中: <var> 指代<body>部分过程
;;        <bindings> 跟一般let一样

;; refactor let select functions
(define (let-variable-pairs exp)
  (let ((subexp (cadr exp)))
    (if (pair? subexp)
	subexp
	(let ((piars (caddr exp))
	      (var (cadr exp))
	      (body-procedure (make-lambda '() (cadddr exp))))
	  (cons (list var body-procedure)
		pairs)))))

(define (let-body exp)
  (let ((subexp (cadr exp)))
    (if (pair? subexp)
	(caddr exp)
	(cadddr exp))))

