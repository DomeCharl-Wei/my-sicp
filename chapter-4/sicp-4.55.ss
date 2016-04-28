;; 跟上上述定义的数据库检索下面信息的简单查询

;; a) 所有被Ben Bitdiddle管理的人
(supervisor ?x (Ben Bididdle))

;; b) 会计部所有人的名字和工作
(job ?name (accounting . ?type))

;; c) 在Slumervile居住的所有人的名字和住址
(address ?name (Slumerville . ?address-detail))
