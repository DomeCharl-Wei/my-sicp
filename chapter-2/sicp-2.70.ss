;; sicp 2.70
(load "sicp-2.69.ss")
(define pairs '((A 2)
                (NA 16)
                (BOOM 1)
                (SHA 3)
                (GET 2)
                (YIP 9)
                (JOB 2)
                (WAH 1)))

(load "sicp-2.68.ss")



(define encoded-code (encode '(GET A JOB
                               SHA NA NA NA NA NA NA NA NA
                               GET A JOB
                               SHA NA NA NA NA NA NA NA NA
                               WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP
                               SHA BOOM)
                             (generate-huffman-tree pairs)))
(load "sicp-utils.ss")
(length encoded)
;; => 87
