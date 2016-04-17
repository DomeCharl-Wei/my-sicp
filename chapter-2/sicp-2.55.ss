;; explain express (car ''abracadabra)
(car ''abracadabra)

;; 因为 ' => quote 运算
''abracadabra => (quote (quote abracadabra))
