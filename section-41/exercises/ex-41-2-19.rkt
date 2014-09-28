#lang racket
(require lang/htdp-advanced)

;; count-vowels : (listof letter) 
;;           ->  (vector number number number number number)
;; where a letter is a symbol in 'a ... 'z
;; to determine how many times the five vowels occur in chars
;; the resulting vector lists the counts in the lexicographic order
(define (count-vowels chars)
  (cond
    [(empty? chars) (vector 0 0 0 0 0)]
    [else
     (local ((define count-rest (count-vowels (rest chars))))
       (begin
         (count-a-vowel (first chars) count-rest)
         count-rest))]))

;; count-a-vowel : letter (vector number number number number number)  ->  void
;; effect: to modify counts at the appropriate place if l is a vowel, 
;; none otherwise
(define (count-a-vowel l counts)
  (cond
   [(symbol=? l 'a) (vector-set! counts 0 (add1 (vector-ref counts 0)))]
   [(symbol=? l 'e) (vector-set! counts 1 (add1 (vector-ref counts 1)))]
   [(symbol=? l 'i) (vector-set! counts 2 (add1 (vector-ref counts 2)))]
   [(symbol=? l 'o) (vector-set! counts 3 (add1 (vector-ref counts 2)))]
   [(symbol=? l 'u) (vector-set! counts 4 (add1 (vector-ref counts 4)))]
   [else (void)]))

(define (count-vowels-bv chars)
  (local ((define (count-vowel x chars)
            (cond
              [(empty? chars) 0]
              [else (cond
                      [(symbol=? x (first chars))
                       (+ (count-vowel x (rest chars)) 1)]
                      [else (count-vowel x (rest chars))])])))
    (build-vector 5 (lambda (i) 
                      (cond
                        [(= i 0) (count-vowel 'a chars)]
                        [(= i 1) (count-vowel 'e chars)]
                        [(= i 2) (count-vowel 'i chars)]
                        [(= i 3) (count-vowel 'o chars)]
                        [(= i 4) (count-vowel 'u chars)])))))

;; random-chars : number -> (vectorof symbol)
;; Creates a vector of random symbols
(define (random-chars count)
  (build-list count (lambda (i) (vector-ref (vector 'a 'b 'c 'd 'e 'f 'g 'h 'i 'j 'k 'l 'm 'n 'o 'p 'q 'r 's 't 'u 'v 'w 'x 'y 'z) (random 26)))))

;; TESTS
(define randomness (random-chars 50000))
(collect-garbage)
(time (count-vowels randomness))
(collect-garbage)
(time (count-vowels-bv randomness))

;; RESULTS
#|
cpu time: 101 real time: 100 gc time: 0
'#(1906 1913 1950 1951 1888)
cpu time: 321 real time: 341 gc time: 0
'#(1906 1913 1950 2010 1888)
|#

;; It can be seen that the count-vowels function works
;; better than the build-vector function at least
;; by an order of magnitude of 3. I think this
;; is because the build-vector function causes the creation
;; of a new vector every time a new vowel is counted.
;; But this effect is reversed when you take out
;; the (require lang/htdp-advanced) bit from the header
;; I suspect this is because of some optimization run
;; under the hood for persistent data structures.
