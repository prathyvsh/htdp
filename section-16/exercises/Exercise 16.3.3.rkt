#lang racket
(require lang/htdp-beginner)

;A file is a structure:
 ;(make-file n s x) 
;where n is a symbol, s is a number, and x is some Scheme value.
(define-struct file1 (name size content))

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

;; FUNCTIONS

;; du-dir : dir -> number
;; Consumes a directory and outputs the size of files contained in the
;; directory.
(define (du-dir dir)
  (cond
    [(empty? dir) 0]
    [else (+ (file-size-directory (dir-dirs dir))
             (fs (dir-files dir)))]))

;; du-dir-mod : dir -> number
;; Consumes a directory and outputs the size of the directory assuming 1
;; storage unit for directories and files.
(define (du-dir-mod dir)
  (cond
    [(empty? dir) 0]
    [else (+ (file-size-directory-mod (dir-dirs dir))
             (fs-mod (dir-files dir)))]))

;; file-size-directory : list-of-directory -> number
;; Calculates the size of the files present in each directory of the
;; given list
(define (file-size-directory lod)
  (cond
    [(empty? lod) 0]
    [else (+ (du-dir (first lod)) (file-size-directory (rest lod)))]))

;; file-count : list-of-files -> number
;; Computes the number of files in the given list.
(define (fs lof)
  (cond
    [(empty? lof) 0]
    [else (+ (file1-size (first lof)) (fs (rest lof)))]))

;; file-size-directory-mod : list-of-directory -> number
;; Calculates the size of the files present in each directory of the
;; given list assuming 1 storage unit for storing each directory.
(define (file-size-directory-mod lod)
  (cond
    [(empty? lod) 0]
    [else (+ 1 (du-dir-mod (first lod)) (file-size-directory-mod (rest lod)))]))

;; file-count : list-of-files -> number
;; Computes the number of files in the given list assuming 1 storage
;; unit for each file.
(define (fs-mod lof)
  (cond
    [(empty? lof) 0]
    [else (+ 1 (file1-size (first lof)) (fs-mod (rest lof)))]))

;; DATA

;; Files
(define read-file (make-file1 'read! 19 empty))
(define hang-file (make-file1 'hang 8 empty))
(define draw-file (make-file1 'draw 2 empty))
(define part1-file (make-file1 'part1 99 empty))
(define part2-file (make-file1 'part2 52 empty))
(define part3-file (make-file1 'part3 17 empty))
(define read-file2 (make-file1 'read! 10 empty))

;; Folders
(define code-dir (make-dir 'Code empty (list hang-file draw-file)))
(define docs-dir (make-dir 'Docs empty (list read-file)))
(define libs-dir (make-dir 'Libs (list docs-dir code-dir) empty))
(define text-dir (make-dir 'Text empty (list part1-file part2-file part3-file)))
(define ts-dir (make-dir 'TS (list text-dir libs-dir) (list read-file2)))

;; TESTS
(equal? (fs (list read-file hang-file)) 27)
(equal? (fs (list part1-file part2-file part3-file)) 168)
(equal? (file-size-directory (list code-dir)) 10)
(equal? (file-size-directory (list text-dir code-dir)) 178)
(equal? (fs-mod (list read-file hang-file)) 29)
(equal? (file-size-directory-mod (list code-dir)) 13)
(equal? (file-size-directory-mod (list libs-dir)) 35)
(equal? (du-dir docs-dir) 19)
(equal? (du-dir code-dir) 10)
(equal? (du-dir libs-dir) 29)
(equal? (du-dir text-dir) 168)
(equal? (du-dir ts-dir) 207)
(equal? (du-dir-mod ts-dir) 218)
(equal? (du-dir-mod code-dir) 12)
