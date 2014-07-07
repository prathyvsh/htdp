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
    [else (or (symbol=? filename (file-name (first lof))) (occurs-in-file-list  filename (rest lof)))]))

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
(check-expect (find? 'read! docs-dir) true)
(check-expect (find? 'hang code-dir) true)
(check-expect (find? 'hang ts-dir) true)
(check-expect (find? 'dinosaur ts-dir) false)
