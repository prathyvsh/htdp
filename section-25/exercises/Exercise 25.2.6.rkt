#lang racket
(require lang/htdp-intermediate-lambda)

;; general-quick-sort : (X X  ->  bool) (list X)  ->  (list X)
(define (general-quick-sort a-predicate a-list)
  (local (
          (define (true-items a-list threshold)
            (filter (lambda (value) (a-predicate value threshold)) a-list))
          (define (false-items a-list threshold)
            (filter (lambda (value) (not (a-predicate value threshold))) a-list))
          (define (quick-sort a-list)
                              (cond
                               [(empty? a-list) empty]
                               [else (append (quick-sort (true-items (rest a-list) (first a-list)))
                                             (list (first a-list))
                                             (quick-sort (false-items (rest a-list) (first a-list))))])))
    (quick-sort a-list)))


;; TESTS
(general-quick-sort < (list 3 2 4 2 8 10))
(general-quick-sort string<? (list "a" "b" "apple" "bucket"))
