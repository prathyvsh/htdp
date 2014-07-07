;; A file is a symbol
;; A directory is either
;; 1. empty
;; 2. (cons f d) where f is a file and d is a dir; or
;; 3. (cons d1 d2) where d1 and d2 are dirs

(define docs (list 'read!))
(define code (list 'hang 'draw))
(define libs (list code docs))
(define text (list 'part1 'part2 'part3))
(define ts (list 'read! text libs))

#|
;; TEMPLATE

(define (template-for-dir dir)
  (cond
    [(empty? dir) ...]
    [(symbol=? (first dir)) ... (first dir) ... (template-for-dir (rest dir)) ... ]
    [else ... (first dir) ... (template-for-dir (rest dir)) ... ]))

|#

;; how-many : directory -> number
;; Counts the number of files in the directory
(define (how-many dir)
  (cond
    [(empty? dir) 0]
    [(symbol? (first dir)) (+ 1 (how-many (rest dir)))]
    [else (+ (how-many (first dir)) (how-many (rest dir)))]))

;; TESTS
(check-expect (how-many ts) 7)
