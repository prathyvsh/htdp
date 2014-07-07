;A file is a structure:
 ;(make-file n s x) 
;where n is a symbol, s is a number, and x is some Scheme value.

;A list-of-files is either

;1. empty, or
;2. (cons s lof) where s is a file and lof is a list of files.

;A dir is a structure:
 ;(make-dir n ds fs) 
;where n is a symbol, ds is a list of directories, and fs is a list of files.

;A list-of-directories is either

;1. empty or
;2. (cons s lod) where s is a dir and lod is a list of directories.

;; FUNCTIONS

;; how-many : dir -> number
;; Counts the number of files present in the given directory
(define (how-many dir)
  (cond
    [(empty? dir) 0]
    [else (+ (files-in-directory-list (dir-dirs dir))
             (file-count (dir-files dir)))]))

;; files-in-directory-list : list-of-directory -> number
;; Calculates the number of files present in each of the directory in
;; the given list
(define (files-in-directory-list lod)
  (cond
    [(empty? lod) 0]
    [else (+ (how-many (first lod)) (files-in-directory-list (rest lod)))]))

;; file-count : list-of-files -> number
;; Computes the number of files in the given list.
(define (file-count lof)
  (cond
    [(empty? lof) 0]
    [else (+ 1 (file-count (rest lof)))]))



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
(define text-dir (make-dir 'Text empty (list part1-file part2-file part3-file)))
(define ts-dir (make-dir 'TS (list text-dir libs-dir) (list read-file2)))

;; TESTS
(check-expect (file-count (list read-file hang-file)) 2)
(check-expect (file-count (list part1-file part2-file part3-file)) 3)
(check-expect (files-in-directory-list (list code-dir)) 2)
(check-expect (files-in-directory-list (list text-dir code-dir)) 5)
(check-expect (how-many docs-dir) 1)
(check-expect (how-many code-dir) 2)
(check-expect (how-many libs-dir) 3)
(check-expect (how-many text-dir) 3)
(check-expect (how-many ts-dir) 7)


#|
 We are confident that our functions work as we have test cases in place to check for their integrity. And also since the individual functions yield the expected result and their combination in the form of the how-many function meets the tests, we are sort of confident that the functions all work as expected in tandem.
 |#
