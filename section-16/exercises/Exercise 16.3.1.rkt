#lang racket
(require lang/htdp-beginner)

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

;; DATA

;; Files
(define read-file (make-file 'read! 19 empty))
(define hang-file (make-file 'hang 8 empty))
(define draw-file (make-file 'draw 2 empty))
(define part1-file (make-file 'part1 99 empty))
(define part2-file (make-file 'part2 52 empty))
(define part3-file (make-file 'part3 17 empty))
(define read-file2 (make-file 'read! 10 empty))

;; Folders
(define code-dir (make-dir 'Code empty (list hang-file draw-file)))
(define docs-dir (make-dir 'Docs empty (list read-file)))
(define libs-dir (make-dir 'Libs (list docs-dir code-dir) empty))
(define text-dir (make-dir 'Text empty (list 'part1 'part2 'part3)))
(define ts-dir (make-dir 'TS (list text-dir libs-dir) (list read-file2)))
