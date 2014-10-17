#lang racket
(require lang/htdp-advanced)

(define-struct person (name date father mother children))

;; A family-tree-node is either
;; false or
;; a person

;; A person is a structure:
;; (make-person n s f m c)
;; where n is a symbol, s is number, f and m are ftns, and c is a (listof person)

;; false represents missing information about a portion of the family tree.

;; add-child! : symbol number ftn ftn  ->  person
;; to construct a person structure for a newborn 
;; effect: to add the new structure to the children of father and mother
(define (add-child! name date father mother)
  (local ((define the-child
	    (make-person name date father mother empty))
          (define (has-father? c) (not (false? (person-father c))))
          (define (has-mother? c) (not (false? (person-mother c)))))
    (begin
      (if (has-father? the-child) (set-person-children! father (cons the-child (person-children father))) (void))
      (if (has-mother? the-child) (set-person-children! mother (cons the-child (person-children mother))) (void))
      the-child)))

;; name-of-cousins : ftn -> number
;; Counts the number of descendants a given node has.
(define (name-of-cousins ft)
  (cond
   [(false? ft) false]
   [else (local
             ((define father (parent ft person-father))
              (define mother (parent ft person-mother))
              (define father-siblings (siblings father))
              (define mother-siblings (siblings mother))
              (define all-siblings (append father-siblings mother-siblings)))
              (map person-name (collect-children all-siblings)))]))

;; collect-grandchildren : (listof person) -> (listof person)
;; Creates a list of children of the given list of persons
(define (collect-children children)
  (foldr (lambda (i j) (append (person-children i) j)) empty children))

;; append-without-duplicates : (listof X) (listof X) ->  (listof X)
;; Appends two list in a way that items in l1 is not added again when
;; appending items of l2
(define (append-without-duplicates l1 l2)
  (local ((define (contains? a l) (ormap (lambda (i) (equal? a i)) l)))
    (append (filter (lambda (i) (not (contains? i l2))) l1) l2)))

;; sibilings : family-tree -> (listof familytree)
;; Collects all the sibilings of same father and mother
(define (siblings ft)
  (cond
   [(false? ft) empty]
   [else (local
             ((define father (person-father ft))
              (define mother (person-mother ft))
              (define (get-children p) (if (false? p) empty (filter (lambda (i) (not (eq? i ft))) (person-children p)))))
           (append-without-duplicates (get-children father) (get-children mother)))]))

;; grandparent : family-tree (family-tree -> family-tree) -> family-tree
;; Gets the grandparent from the given family teree
(define (grandparent ft relation) (get-nth-generation 2 ft relation))

;; grandparent : family-tree (family-tree -> family-tree) -> family-tree
;; Gets the parent from the given family teree
(define (parent ft relation) (get-nth-generation 1 ft relation))

;; get-nth-generation : N family-tree (family-tree -> family-tree) -> family-tree
;; Gets the nth generation node in the given family tree as per the specified relation
(define (get-nth-generation n ft relation)
  (local ((define (relation-or-false v) (if (equal? v false) false (relation v))))
    (cond
     [(= n 0) ft]
     [(false? ft) false]
     [else (relation-or-false (get-nth-generation (sub1 n) ft relation))])))

  ;; TESTS

;; First Generation
(define Fred (add-child! 'Fred 1900 false false))
(define Tina (add-child! 'Tina 1913 false false))

;; Second Generation
(define Malcolm (add-child! 'Malcolm 1920 false false))
(define Jenna (add-child! 'Jenna 1943 Fred Tina))

(define Joseph (add-child! 'Joseph 1927 false false))
(define Rose (add-child! 'Rose 1933 Fred Tina))

;; Third Generation
(define Judith (add-child! 'Judith 1960 false false))
(define James (add-child! 'James 1955 Malcolm Jenna))

(define Tony (add-child! 'Tony 1955 Malcolm Jenna))
(define Betty (add-child! 'Betty 1961 false false))

;; Fourth Generation
(define Bob (add-child! 'Bob 1972 James false))
(define Martha (add-child! 'Martha 1980 false false))
(define Ben (add-child! 'Ben 1975 James Judith))

;; Fifth Generation
(define Tom (add-child! 'Tom 1990 Tony Betty))

(name-of-cousins Betty)
