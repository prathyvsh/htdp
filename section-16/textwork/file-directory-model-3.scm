;A file is a structure:
 ;(make-file n s x) 
;where n is a symbol, s is a number, and x is some Scheme value.
(define-struct file (name size content))

;A list-of-files is either

;1. empty, or
;2. (cons s lof) where s is a file and lof is a list of files.

;A dir is a structure:
 ;(make-dir n ds fs) 
;where n is a symbol, ds is a list of directories, and fs is a list of files.
(define-struct dir (name dirs files))

;A list-of-directories is either

;1. empty or
;2. (cons s lod) where s is a dir and lod is a list of directories.
