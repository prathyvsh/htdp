(define (is-between? x y n)
  (and (> n x) (< n y)))

(define (is-between-left-inclusive? x y n)
  (and (>= n x) (< n y)))

(define (is-between-right-inclusive? x y n)
  (and (> n x) (<= n y)))

(define (is-between-both-inclusive? x y n)
  (and (>= n x) (<= n y)))

;; (3,7]
(define (interval-1 n)
  (is-between-right-inclusive? 3 7 n))

;; [3,7]
(define (interval-2 n)
  (is-between-both-inclusive? 3 7 n))

;; [3,9)
(define (interval-3 n)
  (is-between-left-inclusive? 3 9 n))

;; (1, 3) and (9 ,11)
(define (interval-4 n)
  (or (is-between? 1 3 n) (is-between? 9 11 n)))

;; outside of [1,3]
(define (interval-5 n)
  (not (is-between-both-inclusive? 1 3 n)))

;; TESTS
(interval-1 3) "should be" false "******"
(interval-1 7) "should be" true "******"
(interval-2 2) "should be" false "******"
(interval-2 3) "should be" true "******"
(interval-3 4) "should be" true "******"
(interval-3 9) "should be" false "******"

(interval-4 2) "should be" true "******"
(interval-4 8) "should be" false "******"

(interval-4 0) "should be" false "******"
(interval-4 5) "should be" false "******"
(interval-4 12) "should be" false "******"

(interval-5 2) "should be" false "******"
(interval-5 3) "should be" false "******"
(interval-5 4) "should be" true "******"
