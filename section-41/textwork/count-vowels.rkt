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
  ...)
