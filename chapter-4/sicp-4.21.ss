;; 总结: Y运算原理实现
;; 首先需要理解递归的阶乘实现
;; 
;; ((lambda (n)
;;    ((lambda (fact)
;;       (fact fact n))
;;     (lambda (ft k)
;;       (if (= k 1)
;; 	     1
;; 	     (* k (ft ft (- k 1)))))))
;;  10)
;;
;; 从最外层看, 这个过程很简单, 就是 ((lambda (n) <body>) 10)
;; 然后拿<body>来分析, 就一个函数的调用,
;; lambda 函数定义为:
;; 
;; (lambda (fact)
;;   (fact fact n))
;; 
;; 结构很让人费解, 但是很清晰, 传入参数是一个过程, 这个过程包含两个参数,
;; 一个是镜像过程(也就是他自己), 另一个是int型, 完了, 就这么多
;; 再看函数的参数, 他也是一个函数的定义, 也就是fact的实际执行体
;; 
;; (lambda (ft k)
;;   (if (= k 1)
;;       1
;;       (* k (ft ft (- k 1)))))
;; 
;; 上面介绍了, 这个函数参数包含一个镜像过程和int型参数, 函数体就是一个if
;; 判断, 包含阶乘递归的终止条件, 和 递归的next step;
;; 先回过头来看看, 阶乘的数学定义: f(n) = n * f(n-1)
;; 再把这个数学定义翻译成scheme代码, 假设我们已经有了一个阶乘函数factorial
;; => (* n (factorial (- n 1)))
;; next step的表示是 (* k (ft ft (- k 1)))
;; 两者已经非常接近了, 只是多了一个ft
;; 因为lambda是匿名函数, 无法通过一个变量来指定函数的定义过程, 所以才需要把
;; fact 定义成 (lambda (ft k) <body>)这种形式, 从一定程度上来说, 这里的
;; 参数ft, 是用来保存匿名函数(lambda (ft k) <body>)的定义; 而这个过程需要
;; 最开始的过程(lambda (fact) (fact fact n))来协助. 想象一下多米诺骨牌,
;; 当前这张牌的推动是由上一张牌完成的, 那最开始的那张牌的推动, 必须借助外力.

;; a. 设计一个算斐波那契数的Y运算
;; 想象一下斐波那契的数学定义 f(n)=f(n-1) + f(n-2), 再结合上面的分析
((lambda (n)
   ((lambda (fib)
      (fib fib n))
    (lambda (fb k)
      (if (or (= k 0)
	      (= k 1))
	  1
	  (+ (fb fb (- k 1))
	     (fb fb (- k 2)))))))
 10)
;; => 89


;; b. 完成相互递归定义的表达式填空
(define (f x)
  ((lambda (even? odd?)
     (even? even? odd? x))
   (lambda (ev? od? n)
     (if (= n 0)
	 #t
	 (od? ev? od? (- n 1))))
   (lambda (ev? od? n)
     (if (= n 0)
	 #f
	 (ev? ev? od? (- n 1))))))
