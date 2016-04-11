(load "/Users/enzo/test/scheme/streams.ss")

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc (map stream-cdr argstreams))))))

(stream-map
 (lambda (a . args)
   (map display (cons a args)))
 (stream-enumerate-interval 1 10)
 (stream-enumerate-interval 11 20))

(caar '((1 2)
        (3 4)))
