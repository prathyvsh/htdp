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
  
