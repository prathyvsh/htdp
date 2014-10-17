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


;; TESTS
(equal? (count-vowels '(a b c d e f g h i)) (vector 1 1 1 0 0))
(equal? (count-vowels '(a a i u u)) (vector 2 0 1 0 2))
