#lang racket
(require lang/htdp-beginner)

(define-struct file1 (name size content))
(define-struct dir (name dirs files))

;; find? : filename directory -> boolean
;; Determines if file with filename occurs in the dir
(define (find? filename dir)
  (cond
    [(empty? dir) false]
    [else (or (occurs-in-sub-dirs filename (dir-dirs dir))
              (occurs-in-file-list filename (dir-files dir)))]))

;; occurs-in-sub-dirs : filename list-of-directory -> boolean
;; Determines if file with filename occurs in the sub
;; directory.
(define (occurs-in-sub-dirs filename lod)
  (cond
    [(empty? lod) false]
    [else (or (find? filename (first lod)) (occurs-in-sub-dirs filename (rest lod)))]))

;; occurs-in-file-list : filename list-of-files -> boolean
;; Determines if file with filename occurs in the given
;; filelist
(define (occurs-in-file-list filename lof)
  (cond
    [(empty? lof) false]
    [else (or (symbol=? filename (file1-name (first lof))) (occurs-in-file-list  filename (rest lof)))]))

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
(equal? (find? 'read! docs-dir) true)
(equal? (find? 'hang code-dir) true)
(equal? (find? 'hang ts-dir) true)
(equal? (find? 'dinosaur ts-dir) false)
