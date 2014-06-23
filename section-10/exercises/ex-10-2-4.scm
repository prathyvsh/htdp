;; An dir-entry is a directory entry comprising of:
;; (make-directory 'symbol number)
(define-struct dir-entry (name number))

;; EXAMPLE
;; A phone directory can be represented as a list of dir-entries
(define a-directory
  (cons (make-dir-entry 'Varun 2334232)
        (cons (make-dir-entry 'Marth 23452243)
              (cons (make-dir-entry 'Jonathan 23532) empty))))

#|
(define (directory-manipulation dir)
  (cond
  [(empty? dir) ...]
  [...(first dir)...(directory-manipulation (rest dir))...]))
 |#

;; whose-number : number directory -> name
;; Determines the name of the given phone number
(define (whose-number num dir)
  (cond
  [(empty? dir) 'Number-Not-Found]
  [else (cond
     [(= num (dir-entry-number (first dir)))
      (dir-entry-name (first dir))]
     [else (whose-number num (rest dir))])]))

;; phone-number : name directory -> number
;; Determines the phone number of the given name
(define (phone-number name dir)
  (cond
  [(empty? dir) 'Name-Not-Found]
  [else (cond
     [(symbol=? name (dir-entry-name (first dir)))
      (dir-entry-number (first dir))]
     [else (phone-number name (rest dir))])]))

;; TESTS
(symbol=? (whose-number 2334232 a-directory) 'Varun)
(= (phone-number 'Varun a-directory) 2334232)
(symbol=? (whose-number 23232 empty) 'Number-Not-Found)
(symbol=? (phone-number 'Barley a-directory) 'Name-Not-Found)
(= (phone-number 'Jonathan a-directory) 23532)
