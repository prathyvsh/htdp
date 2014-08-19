;; displacement : (vectorof number) number  ->  (vectorof number)
;; to compute the displacement of v and t
(define (displacement v t)
  (build-vector (vector-length v) (lambda (i) (* (vector-ref v i) t))))
