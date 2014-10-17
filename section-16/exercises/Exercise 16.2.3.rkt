#lang racket
(require lang/htdp-beginner)

;;A directory (short: dir) is a structure:
 ;;(make-dir n c size system) 
;;where n is a symbol, c a list of files and directories,
;;size a number that represents the size of the files and folders contained in the directory
;;and size a boolean which records if the directory is recognized by
;;the operating system.
(define-struct dir (name c size sys))

;;A list-of-files-and-directories (short: LOFD) is either
;;
;; 1. empty
;;
;; 2. (cons f d) where f is a file, represented by a symbol and d is a LOFD

;;3. (cons d1 d2) where d1 is a dir and d2 is a LOFD

