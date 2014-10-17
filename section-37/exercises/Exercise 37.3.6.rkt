#lang racket
(require htdp/dir)
(require lang/htdp-advanced)

;; STATE VARIABLES
;; how-many-directories : number
;; Keeps track of the number of subdirectories
;; found in each scan.
(define how-many-directories 0)

;; init-directory-scan -> void
;; Initializes directory search
(define (init-directory-scan)
  (set! how-many-directories 0))

;; dir-listing : directory -> (listof symbol)
;; Consumes a directory and produces the list of
;; all files and subdirectories present in it.
;; Effect: Increases the how-many-directories count
(define (dir-listing dir)
  (cond
   [(empty? dir) empty]
   [else (begin (set! how-many-directories (add1 how-many-directories))
                (append (list (dir-name dir)) (collect-filename (dir-files dir)) (dir-listing/list (dir-dirs dir))))]))

;; collect-filename : (listof file) -> (listof symbol)
;; Collects the name of all files
(define (collect-filename lof)
  (map file-name lof))

;; dir-listing/list : (listof dir) -> (listof symbol)
;; Consumes a directory and produces the list of
;; all files and subdirectories present in the list
;; of directories
(define (dir-listing/list lod)
  (foldr append empty (map dir-listing lod)))

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
(begin (init-directory-scan)
(and (equal? (dir-listing libs-dir)
        '(Libs Docs read! Code hang draw))
(equal? how-many-directories 3)))

(begin (init-directory-scan)
(and (equal? (dir-listing ts-dir)
        '(TS read! Text part1 part2 part3 Libs Docs read! Code hang draw))
(equal? how-many-directories 5)))
