;; file->list-of-lines : file  ->  (listof (listof symbol))
;; to convert a file into a list of lines 
(define (file->list-of-lines afile)
  (cond
    [(empty? afile) empty]
    [else
      (cons (first-line afile)
	    (file->list-of-lines (remove-first-line afile)))]))

;; first-line : file  ->  (listof symbol)
;; to compute the prefix of afile up to the first occurrence of NEWLINE
(define (first-line afile)
  (cond
    [(empty? afile) empty]
    [else (cond
	    [(symbol=? (first afile) NEWLINE) empty]
	    [else (cons (first afile) (first-line (rest afile)))])]))

;; remove-first-line : file  ->  (listof symbol)
;; to compute the suffix of afile behind the first occurrence of NEWLINE
(define (remove-first-line afile)
  (cond
    [(empty? afile) empty]
    [else (cond
	    [(symbol=? (first afile) NEWLINE) (rest afile)]
	    [else (remove-first-line (rest afile))])]))

(define NEWLINE 'NL)
