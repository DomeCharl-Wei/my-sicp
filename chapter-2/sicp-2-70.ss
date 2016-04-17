;; sicp-2-70: The following eight-symbol alphabet with associated relative
;; frequencies was designed to efficiently encode the lyrics of 1950s rock
;; songs. (Note that the "symbols" of an "alphabet" need not be individual
;; letters.)
;;
;; A      2   NA     16
;; BOOM   1   SHA    3
;; GET    2   YIP    9
;; JOB    2   WAH    1
;;
;; Use generate-huffman-tree to generate a corresponding Huffman tree, and
;; use encode to encode the following message:
;;

(load "sicp-2-68.ss")
(load "sicp-2-69.ss")

(define pairs
  '((leaf A 2)
    (leaf BOOM 1)
    (leaf GET 2)
    (leaf JOB 2)
    (leaf NA 16)
    (leaf SHA 3)
    (leaf YIP 9)
    (leaf WAH 1)))

(define huffman-tree
  (generate-huffman-tree pairs))
;;
;; '((leaf NA 16)
;; ((leaf YIP 9)
;;  ((leaf SHA 3)
;;   ((leaf A 2)
;;    ((leaf GET 2)
;;     ((leaf JOB 2) ((leaf BOOM 1) (leaf WAH 1) (BOOM WAH) 2) (JOB BOOM WAH) 4)
;;     (GET JOB BOOM WAH)
;;     6)
;;    (A GET JOB BOOM WAH)
;;    8)
;;   (SHA A GET JOB BOOM WAH)
;;   11)
;;  (YIP SHA A GET JOB BOOM WAH)
;;  20)
;; (NA YIP SHA A GET JOB BOOM WAH)
;; 36)


;; encoding message 'Get a job'
(encode '(GET A JOB) huffman-tree)
;; => '(1 1 1 1 0 1 1 1 0 1 1 1 1 1 0)

;; encoding message 'SHA NA NA NA NA NA NA NA'
(encode '(SHA NA NA NA NA NA NA NA) huffman-tree)
;; => '(1 1 0 0 0 0 0 0 0 0)
