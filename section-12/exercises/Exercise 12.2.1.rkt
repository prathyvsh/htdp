#lang racket
(require lang/htdp-beginner)

;; DATA DEFINITION
;; A mail is (make-mail string number string)
(define-struct mail (from date message))

;; DATA EXAMPLES
(define mail1 (make-mail "Ravi" 27062014 "Job Offer"))
(define mail2 (make-mail "Apple" 25062014 "WWDC Videos"))
(define mail3 (make-mail "Google" 26062014 "Material Design"))
(define mail4 (make-mail "NigerianPrince" 24062014 "All my base are belong to you"))

(define mail-list (cons mail1 (cons mail2 (cons mail3 (cons mail4 empty)))))

;; WISH LIST
;; sort-by-date : list-of-mail -> list-of-mail
;; Creates a sorted list of mails by date.

;; insert-by-date : mail list-of-mail -> list-of-mail
;; Produces a sorted mail list with given mail at the right location.

;; sort-by-name : lits-of-mail -> list-of-mail
;; Creates a sorted list of mails by name.

;; FUNCTIONS
;; sort-by-date : list-of-mail -> list-of-mail
;; Creates a sorted list of mails by date.
(define (sort-by-date lom)
  (cond
    [(empty? lom) empty]
    [else (insert-by-date (first lom) (sort-by-date (rest lom)))]))

;; insert-by-date : mail list-of-mail -> list-of-mail
;; Produces a sorted mail list with given mail at the right descending location.
(define (insert-by-date a-mail slom)
  (cond
    [(empty? slom) (cons a-mail empty)]
    [else 
      (cond
        [(< (mail-date a-mail) (mail-date (first slom))) (cons a-mail slom)]
        [(>= (mail-date a-mail) (mail-date (first slom)))
              (cons (first slom) (insert-by-date a-mail (rest slom)))])]))

;; sort-by-name : lits-of-mail -> list-of-mail
;; Creates a sorted list of mails by name.
(define (sort-by-name lom)
  (cond
    [(empty? lom) empty]
    [else (insert-by-name (first lom) (sort-by-name (rest lom)))]))

;; insert-by-name : mail list-of-mail -> list-of-mail
;; Produces a sorted mail list with given mail at the right location in
;; descending order of name.
(define (insert-by-name a-mail slom)
  (cond
    [(empty? slom) (cons a-mail empty)]
    [else 
      (cond
        [(string<? (mail-from a-mail) (mail-from (first slom))) (cons a-mail slom)]
        [(string>=? (mail-from a-mail) (mail-from (first slom)))
              (cons (first slom) (insert-by-name a-mail (rest slom)))])]))


;; TESTS
(sort-by-date mail-list) "should be" (cons mail4 (cons mail2 (cons mail3 (cons mail1 empty))))
(sort-by-name mail-list) "should be" (cons mail2 (cons mail3 (cons mail4 (cons mail1 empty))))
(sort-by-name empty) "should be" empty
(sort-by-date empty) "should be" empty
