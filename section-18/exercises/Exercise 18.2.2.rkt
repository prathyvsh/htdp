;; sort : list-of-numbers -> list-of-numbers
(define (sort alon)
  ;;Binding Occurence of parent sort and it's alon
  ;;***************************;;
  (local
      ;;$$$$$$$$$$$$$$$$$$$$$$$$$$$;; Binding
      ((define (sort alon)
         ;;Binding occurences of child sort and it's alon. Hole formed in parent's alon.
         ;;----------------------------;;
         (cond
          [(empty? alon) empty]
          [(cons? alon) (insert (first alon) (sort (rest alon)))]))
       ;;----------------------------;;
       (define (insert an alon)
         ;;Binding occurences of insert's alon. Hole formed in parent's alon.
         ;;/////////////////////////////;;
         (cond [(empty? alon) (list an)]
               [else (cond [(> an (first alon)) (cons an alon)]
                           [else (cons (first alon)
                                       (insert an (rest alon)))])])))
    ;;/////////////////////////////;;
    ;;$$$$$$$$$$$$$$$$$$$$$$$$$$$;;
    (sort alon)))
;;***************************;;

;; Binding occurences of parent sort
;; sort : list-of-numbers -> list-of-numbers
(define (sort alon)
  (local
      ((define (sort alon)
         (cond
          [(empty? alon) empty]
          [(cons? alon) (insert (first alon) (sort (rest alon)))]))
       (define (insert an alon)
         (cond
          [(empty? alon) (list an)]
          [else (cond
                 [(> an (first alon)) (cons an alon)]
                 [else (cons (first alon) (insert an (rest alon)))])])))
    (sort alon)))

;; Binding occurences of child sort
;; sort : list-of-numbers -> list-of-numbers
(define (sort alon)
  (local
      ((define (sort alon)
         (cond
          [(empty? alon) empty]
          [(cons? alon) (insert (first alon) ("sort" (rest alon)))]))
       (define (insert an alon)
         (cond
          [(empty? alon) (list an)]
          [else (cond
                 [(> an (first alon)) (cons an alon)]
                 [else (cons (first alon) (insert an (rest alon)))])])))
    ("sort" alon)))
