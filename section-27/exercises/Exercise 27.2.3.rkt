#lang racket
(require lang/htdp-intermediate-lambda)

;; DATA DEFINITION

;; A file of numbers is either

;; empty, or
;; (list number file)
;; (list 'NL file)

;; A restaurant record is
;; (make-rr (number (list number)))
(define-struct rr (table costs))

(define NEWLINE 'NL)

;; file->list-of-checks : file  ->  (listof record)
;; to convert a file into a list of restaurant records
(define (file->list-of-checks afile)
  (local (
          ;; prefix : file (file -> line) (number/symbol line) -> line
          ;; Abstraction for first-line and remove-first-line
          (define (prefix base combine afile)
            (cond
             [(empty? afile) empty]
             [else (cond [(and (symbol? (first afile)) (symbol=? (first afile) NEWLINE)) (base afile)]
                         [else (combine (first afile) (prefix base combine (rest afile)))])]))

          ;; remove-first-line : file  ->  (listof number/symbol)
          ;; to compute the suffix of afile behind the first occurrence of NEWLINE
          (define (remove-first-line afile)
            (prefix rest (lambda (x y) y) afile))

          ;; first-line : file  ->  (listof number/symbol)
          ;; to compute the prefix of afile up to the first occurrence of NEWLINE
          (define (first-line afile)
            (prefix (lambda (x) empty) cons afile)))
    (cond
     [(empty? afile) empty]
     [else (local ((define a-row (first-line afile)))
             (cons (make-rr (first a-row) (rest a-row))
                   (file->list-of-checks (remove-first-line afile))))])))

;; TESTS
(equal? (file->list-of-checks
         (list 1 2.30 4.00 12.50 13.50 'NL
               2 4.00 18.00 'NL
               4 2.30 12.50))
        (list (make-rr 1 (list 2.30 4.00 12.50 13.50))
              (make-rr 2 (list 4.00 18.00))
              (make-rr 4 (list 2.30 12.50))))

(equal? (file->list-of-checks
         (list 1 2.30 4.00 12.50 13.50 'NL
               2 'NL
               4 2.30 12.50))
        (list (make-rr 1 (list 2.30 4.00 12.50 13.50))
              (make-rr 2 empty)
              (make-rr 4 (list 2.30 12.50))))
