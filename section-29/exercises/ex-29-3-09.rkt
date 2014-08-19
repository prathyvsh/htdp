#lang racket
(require lang/htdp-intermediate-lambda)

;; binary-contains? : vector number -> number
;; Searchs for key inside the vector and returns its index
(define (binary-contains? vec key)
  (local ((define initial-left 0)
          (define initial-right (sub1 (vector-length vec)))
          (define init-lvalue (vector-ref vec initial-left))
          (define init-rvalue (vector-ref vec initial-right))
          (define (binary-search left right v-left v-right)
            (cond
             [(= v-right key) right]
             [(= v-left key) left]
             [(or (= (- right left) 1)
                  (< key v-left)
                  (> key v-right)) false]
             [else
             (local ((define mid (floor (/ (+ left right) 2)))
                     (define v-mid (vector-ref vec mid)))
               (cond
             [(<= v-mid key v-right) (binary-search mid right v-mid v-right)]
             [(<= v-left key v-mid) (binary-search left mid v-left v-mid)]))])))
    (binary-search initial-left initial-right init-lvalue init-rvalue)))

;; TESTS

(equal? (binary-contains? (vector 1 2 3 4 8) 6) false)
(equal? (binary-contains? (vector 1 2 3 4 8) 3) 2)
(equal? (binary-contains? (vector 2 2 3 8 9 10) 9) 4)
(equal? (binary-contains? (vector 23 24 25 26 29 32 33 36 49 51) 29) 4)
(equal? (binary-contains? (vector 23 24 25 26 29 32 33 36 49 51) 29) 4)
(equal? (binary-contains? (vector 23 24 25 26 29 32 33 36 49 51) 52) false)
(equal? (binary-contains? (vector 23 24 25 26 29 32 33 36 49 51) 31) false)

;; For each execution of binary-contains? the search space gets
;; halved. Hence for each recursive call, the search space is
;; repeatedly halved (N/2)/2. Hence the execution time depends
;; on how many times N can be halved, which yields O(log N)

;; Vectors is preferable to be used in the case of
;; determining presence of some given number since
;; the access happens in constant time.
