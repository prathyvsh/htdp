#lang racket
(require lang/htdp-intermediate-lambda)

;; DATA DEFINITION

;; A file is either
;; empty
;; or (list symbol file)

(define NEWLINE 'NL)

;; file->list-of-lines : file  ->  (listof (listof symbol))
;; to convert a file into a list of lines 
(define (file->list-of-lines afile)
  (local (
          ;; prefix : file (file -> line) (symbol line) -> line
          ;; Abstraction for first-line and remove-first-line
          (define (prefix base combine afile)
            (cond
             [(empty? afile) empty]
             [else (cond [(symbol=? (first afile) NEWLINE) (base afile)]
                         [else (combine (first afile) (prefix base combine (rest afile)))])]))
          ;; remove-first-line : file  ->  (listof symbol)
          ;; to compute the suffix of afile behind the first occurrence of NEWLINE
          (define (remove-first-line afile)
            (prefix rest (lambda (x y) y) afile))

          ;; first-line : file  ->  (listof symbol)
          ;; to compute the prefix of afile up to the first occurrence of NEWLINE
          (define (first-line afile)
            (prefix (lambda (x) empty) cons afile)))
    (cond
     [(empty? afile) empty]
     [else
      (cons (first-line afile)
	    (file->list-of-lines (remove-first-line afile)))])))


;; TESTS
(file->list-of-lines (list 'Apple 'Orange 'Lemon 'NL 'Cucumber 'Tomato 'Lettuce 'NL))
                           
