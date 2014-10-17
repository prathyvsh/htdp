;; fun-for-ftn : ftn  ->  ???
(define (fun-for-ftn a-ftree)
  (cond
    [(empty? a-ftree) ...]
    [else ... (fun-for-ftn (child-father a-ftree)) ...
          ... (fun-for-ftn (child-mother a-ftree)) ...
          ... (child-name a-ftree) ...
          ... (child-date a-ftree) ...
          ... (child-eyes a-ftree) ...]))

;; blue-eyed-ancestor? : ftn -> boolean
;; to determine whether a-ftree contains a child
;; structure with 'blue in the eyes field
(define (blue-eyed-ancestor? a-ftree)
  (cond
    [(empty? a-ftree) false]
    [else (or (symbol=? (child-eyes a-ftree) 'blue)
              (or (blue-eyed-ancestor? (child-father a-ftree))
                  (blue-eyed-ancestor? (child-mother a-ftree))))]))
