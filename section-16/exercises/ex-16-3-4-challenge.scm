;; find? : filename directory -> boolean
;; Determines if file with filename occurs in the dir
(define (find filename dir)
  (cond
    [(empty? dir) false]
    [else (build-breadcrumbs (list (dir-name dir))
                           (occurs-in-file-list filename (dir-files dir))
                           (occurs-in-sub-dirs filename (dir-dirs dir)))]))

;; build-breadcrumbs
(define (build-breadcrumbs v1 v2 v3)
  (cond
    [(and (boolean? v2) (boolean? v3)) false]
    [(boolean? v2) (append v1 v3)]
    [(boolean? v3) (append v1 v2)]
    [else (list (append v1 v2) (append v1 v3))]))


;; occurs-in-sub-dirs : filename list-of-directory -> boolean
;; Determines if file with filename occurs in the sub
;; directory.
(define (occurs-in-sub-dirs filename lod)
  (cond
    [(empty? lod) false]
    [else (append-or-false (find filename (first lod)) (occurs-in-sub-dirs filename (rest lod)))]))

(define (append-or-false v1 v2)
  (cond
    [(and (boolean? v1) (boolean? v2)) false]
    [(boolean? v1) v2]
    [(boolean? v2) v1]
    [else (append v1 v2)]))

;; occurs-in-file-list : filename list-of-files -> boolean
;; Determines if file with filename occurs in the given
;; filelist
(define (occurs-in-file-list filename lof)
  (cond
    [(empty? lof) false]
    [(symbol=? filename (file-name (first lof))) empty]
    [else (occurs-in-file-list filename (rest lof))]))

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
(check-expect (find 'hang code-dir) (list 'Code))
(check-expect (find 'read! docs-dir) (list 'Docs))
(check-expect (find 'hang libs-dir) (list 'Libs 'Code))
(check-expect (find 'draw code-dir) (list 'Code))
(check-expect (find 'hang ts-dir) (list 'TS 'Libs 'Code))
(check-expect (find 'read! ts-dir) (list (list 'TS) (list 'TS 'Libs 'Docs)))
