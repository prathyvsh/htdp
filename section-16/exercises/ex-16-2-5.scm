;;A directory (short: dir) is a structure:
 ;;(make-dir n c) 
;;where n is a symbol and c is a list of files and directories.
;;
(define-struct dir (n c))
;;A list-of-files-and-directories (short: LOFD) is either
;;
;; 1. empty
;;
;; 2. (cons f d) where f is a file represented by a symbol and d is a LOFD

;;3. (cons d1 d2) where d1 is a dir and d2 is a LOFD
;;
(define docs (make-dir 'docs (list 'read!)))
(define code (make-dir 'code (list 'hang 'draw)))
(define libs (make-dir 'libs (list code docs)))
(define text (make-dir 'text (list 'part1 'part2 'part3)))
(define ts (make-dir 'ts (list 'read! text libs)))
  
#|

;; TEMPLATE

(define (template-for-dir dir)
  (... (dir-n dir) ... (dir-n)))

(define (template-for-lofd a-lofd)
  (cond
    [(empty? a-lofd) ...]
    [(symbol=? (first a-lofd)) ... (first a-lofd) ... (template-for-lofd (rest a-lofd)) ...]
    [else (first a-lofd) ... (template-for-lofd (rest a-lofd)) ...]))

|#

(define (how-many dir)
  (count-files (dir-c dir)))

(define (count-files lofd)
  (cond
    [(empty? lofd) 0]
    [(symbol? (first lofd)) (+ 1 (count-files (rest lofd)))]
    [else (+ (how-many (first lofd)) (count-files (rest lofd)))]))

;; TESTS
(check-expect (how-many docs) 1)
(check-expect (how-many code) 2)
(check-expect (how-many libs) 3)
(check-expect (how-many text) 3)
(check-expect (how-many ts) 7)
