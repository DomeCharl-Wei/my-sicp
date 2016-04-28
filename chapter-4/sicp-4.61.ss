;; 下面规则实现了next-to关系, 它找出一个表里的相邻元素:
;; (rule (?x next-to ?y in (?x ?y . ?u)))
;; (rule (?x next-to ?y in (?v . ?z))
;;       (?x next-to ?y in ?z))
;;
;; 下面的查询将会得到什么回应?
;; (?x next-to ?y in (1 (2 3) 4))
;; => (1 next-to (2 3) in (1 (2 3) 4))
;;
;; (?x next-to 1 in (2 1 3 1))
;; => (3 next-to 1 in (2 1 3 1))
