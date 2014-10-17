;;A directory (short: dir) is a structure:
 ;;(make-dir n c) 
;;where n is a symbol and c is a list of files and directories.
;;
;;A list-of-files-and-directories (short: LOFD) is either
;;
;; 1. empty
;;
;; 2. (cons f d) where f is a file, represented by a symbol and d is a LOFD

;;3. (cons d1 d2) where d1 is a dir and d2 is a LOFD
