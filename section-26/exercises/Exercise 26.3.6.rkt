#lang racket

;; insertion-sort : list-of-numbers -> list-of-numbers
;; to create a sorted list of numbers from all the numbers in alon
(define (insertion-sort alon)
  (local ((define (insert n alon)
            (cond [(empty? alon) (cons n empty)]
                  [else (cond [(< n (first alon)) (cons n alon)]
                              [(>= n (first alon)) (cons (first alon) (insert n (rest alon)))])])))
    (cond [(empty? alon) empty]
          [else (insert (first alon) (insertion-sort (rest alon)))])))

;; quick-sort : (listof number)  ->  (listof number)
;; to create a list of numbers with the same numbers as
;; alon sorted in ascending order
;; assume that the numbers are all distinct 
(define (quick-sort alon)
  (cond [(empty? alon) empty]
        [else (append (quick-sort (smaller-items (rest alon) (first alon)))
                      (list (first alon))
                      (quick-sort (larger-items (rest alon) (first alon))))]))

;; combined-sort : (listof number)  ->  (listof number)
;; to create a list of numbers with the same numbers as
;; alon sorted in ascending order
;; assume that the numbers are all distinct 
(define (combined-sort alon)
  (local ((define threshold 12))
    (cond [(< (length alon) threshold) (insertion-sort alon)]
          [(empty? alon) empty]
          [else (append
                 (combined-sort (smaller-items (rest alon) (first alon))) 
                 (list (first alon)) 
                 (combined-sort (larger-items (rest alon) (first alon))))])))

;; larger-items : (listof number) number  ->  (listof number)
;; to create a list with all those numbers on alon  
;; that are larger than threshold
(define (larger-items alon threshold)
  (filter (lambda (value) (>= value threshold)) alon))

;; smaller-items : (listof number) number  ->  (listof number)
;; to create a list with all those numbers on alon  
;; that are smaller than threshold
(define (smaller-items alon threshold)
  (filter (lambda (value) (< value threshold)) alon))

;; create-tests : number -> (listof number)
;; Creates a list of random numbers under 100 to
;; be tested on the sort functions.
(define (create-tests number)
  (build-list number (lambda (x) (random 100))))

;; list-builder : number -> (number -> (listof number))
;; Builds test cases for the sort functions.
;; Count determines the number of elements in a list
(define (list-builder count) (list (create-tests count)))

;; build-tests : number number -> (listof (listof number))
;; Builds a list of test cases for the sort functions.
(define (build-tests element-count test-count)
  (build-list test-count (lambda (x) (list-builder element-count))))

;; NOTE TO READER
;; Since the question asks for an optimum number,
;; it requires a lot of experiments to be conductd.
;; The default function instructed to be used was
;; the time function but it tended to be tedious
;; to check results each time with various test cases.
;; Had to do research on how to acquire the timing results
;; so that the process can be automated. The functions devised
;; uses (define-values) function which I haven't
;; quite understood the working of, but seems like the
;; only way to scrape cpu values of timings.

;; is-cpu-result : (listof (listof number)) -> number
;; Gets the cpu timing of Insertion Sort function
(define (is-cpu-result test-case)
  (define-values (result cpu real-time gc) (time-apply insertion-sort test-case)) cpu)

;; qs-cpu-result : (listof (listof number)) -> number
;; Gets the cpu timing of Quick Sort function
(define (qs-cpu-result test-case)
  (define-values (result cpu real-time gc) (time-apply quick-sort test-case)) cpu)

;; Note to Self:
;; Should probably build a better way to prefix an index on the test result.
(define (print-result result)
  (reverse (foldl (lambda (x y) (cons (list 'Test (add1 (length y)) x) y)) empty result)))

(define (process-results check is-result qs-result)
  (cond
   [(and (empty? is-result) (empty? qs-result)) 0]
   [(or (empty? is-result) (empty? qs-result)) (error 'determine-wins "Please provide result sets with same number of tests")]
   [else (cond
          [(check (first is-result) (first qs-result)) (+ 1 (process-results check (rest is-result) (rest qs-result)))]
          [else (process-results check (rest is-result) (rest qs-result))])]))

;; TESTS
(equal? (process-results < (list 3) (list 5)) 1)
(equal? (process-results < (list 3 4) (list 5 4)) 1)
(equal? (process-results > (list 3 4) (list 5 4)) 0)
(equal? (process-results > (list 5 4) (list 3 4)) 1)
(equal? (process-results = (list 5 4) (list 3 4)) 1)

#|
;; TEST RESULTS
;; Based on CPU Times of 10000 tests

;; List Length : 5
"Results"
"Is Wins"
46
"Qs Wins"
36
"Ties"
9918

;; List Length : 10
"Results"
"Is Wins"
101
"Qs Wins"
92
"Ties"
9807

;; List Length : 20
"Results"
"Is Wins"
194
"Qs Wins"
278
"Ties"
9528

;; List Length : 30
"Results"
"Is Wins"
301
"Qs Wins"
607
"Ties"
9092

;; List Length : 40
"Results"
"Is Wins"
424
"Qs Wins"
1044
"Ties"
8532

;; List Length : 50
"Results"
"Is Wins"
488
"Qs Wins"
1488
"Ties"
8024
|#

;; TEST OBSERVATION AND THRESHOLD DETERMINATION
;; The crossover point though ambigous, (possibly due to the nature of generation
;; of random numbers) seems to be at 11. Following is the combined sort algorithm
;; with the given threshold.

;; cs-cpu-result : (listof (listof number)) -> number
;; Gets the cpu timing of Combined Sort function
(define (cs-cpu-result test-case)
  (define-values (result cpu real-time gc) (time-apply combined-sort test-case)) cpu)

;; There is still more scope of abstracting the functions.
;; But stopping here partially due to time constraints
;; and partially in the fear of abstracting too much
;; away from the scope of the question.

(define list-length 40)
(define test-count 10000)

(define test-cases (build-tests list-length test-count))
(collect-garbage)
(define is-results (map is-cpu-result test-cases))
(collect-garbage)
(define qs-results (map qs-cpu-result test-cases))

"Results: IS. vs QS."
"IS Wins"
(process-results < is-results qs-results)
"QS Wins"
(process-results < qs-results is-results)
"Ties"
(process-results = is-results qs-results)

"Results: CS. vs QS."
(collect-garbage)
(define cs-results (map cs-cpu-result test-cases))

"CS Wins"
(process-results < cs-results qs-results)
"QS Wins"
(process-results < qs-results cs-results)
"Ties"
(process-results = cs-results qs-results)

;; It can be seen that Combined Sort is performing better
;; than quick sort for values greater than the threshold
;; and reverting back to insertion sort on values lesser
;; than it.
