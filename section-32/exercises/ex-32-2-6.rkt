#lang racket
(require lang/htdp-intermediate-lambda)

(define MC 3)
(define BOAT-CAPACITY 2)

;; A distribution is
;; (make-distribution number number)
(define-struct distribution (mis can))

;; A boat is
;; (make-boat symbol distribution)
(define-struct boat (at-dock load))

;; A board is
;; (make-board distribution boat distribution
(define-struct board (beg boat end))

;; make-BOAT-LOAD : number -> (listof distribution)
;; Creates a list of all possible boat loads.
(define (make-BOAT-LOAD capacity)
  ;; Better Approach
  ;; make-limit-triangle : number -> (listof distribution)
  (local ((define (make-limit-triangle limit)
    (local ((define (make-distributions m c)
              (cond
               [(> m limit) empty]
               [(> (+ m c) limit) (make-distributions (add1 m) 0)]
               [else (cons (make-distribution m c) (make-distributions m (add1 c)))])))
      (make-distributions 0 1))))
  (make-limit-triangle (min capacity MC))))

(define BOAT-LOADS (make-BOAT-LOAD BOAT-CAPACITY))

;; draw-board : board -> (listof (listof symbol) (listof (listof symbol)) (listof symbol))
;; Draws the given board on console.
(define (draw-board lay-of-land)
  (list (draw-land (board-beg lay-of-land)) (draw-boat (board-boat lay-of-land)) (draw-land (board-end lay-of-land))))

;; draw-land : distribution -> (listof symbol)
;; Draws a given distribution
(define (draw-land dist)
  (local ((define priest-count (distribution-mis dist))
          (define cannibal-count (distribution-can dist))
          (define (draw-remaining-elements x) (draw-representation (- MC x) '_)))
    (append (draw-representation priest-count '+) (draw-remaining-elements priest-count)
            (draw-representation cannibal-count '^) (draw-remaining-elements cannibal-count))))

;; draw-can : distribution -> (listof symbol)
;; Draws cannibals as ^s
(define (draw-can dist)
  (draw-representation (distribution-can dist) '+))

;; draw-mis : distribution -> (listof symbol)
;; Draws missionaries as +s
(define (draw-mis dist)
  (draw-representation (distribution-mis dist) '+))

;; draw-representation : count symbol -> (listof symbol)
;; Draws a given symbol count times.
(define (draw-representation count symbol)
  (build-list count (lambda (x) symbol)))

;; draw-boat : boat -> (listof (listof symbol))
;; Draws a boat as list of list of symbols.
(define (draw-boat boat)
  (local ((define (draw-boat-load dist)
            (append (draw-mis dist) (draw-can dist))))
    (cond [(boat-at-dock boat) (list (draw-boat-load (boat-load boat)) '~)]
          [else (list '~ (draw-boat-load (boat-load boat)))])))


;; next-board : board boat -> board
;; Creates the next state of the board with the given boat state
(define (next-board board boat)
  (cond
   [(boat-at-dock boat) (manip-board distribution- distribution+ boat board)]
   [else (manip-board distribution+ distribution- boat board)]))

(define (manip-board beg-op end-op boat board)
  (make-board (beg-op (board-beg board) (boat-load boat))
              (make-boat (not (boat-at-dock boat)) (make-distribution 0 0))
              (end-op (board-end board) (boat-load boat))))

;; distribution-op : distribution distribution (number number -> number) -> distribution
;; Performs an operation that combines two distributions
(define (distribution-op dist1 dist2 op)
  (make-distribution (op (distribution-mis dist1) (distribution-mis dist2))
                     (op (distribution-can dist1) (distribution-can dist2))))

;; distribution- : distribution distribution -> distribution
(define (distribution- dist1 dist2) (distribution-op dist1 dist2 -))

;; distribution+ : distribution distribution -> distribution
(define (distribution+ dist1 dist2) (distribution-op dist1 dist2 +))

;; generate-possible-boards : board -> (listof board)
;; Creates all possible board combinations from the given one with
;; one boat transport to the other side.
(define (generate-possible-boards board)
  (filter legal-state? (map (lambda (x) (next-board board (make-boat (boat-at-dock (board-boat board)) x))) BOAT-LOADS)))

;; draw-boards : (listof board) -> void
;; Draws all the boards in the given list.
(define (draw-boards boards)
  (for-each (lambda (x) (pretty-print (draw-board x))) boards))

;; legal-state? : board -> boolean
;; Determines if the given board is a legal one
(define (legal-state? board)
  (local ((define priests-at-beg (distribution-mis (board-beg board)))
          (define cannibals-at-beg (distribution-can (board-beg board)))
          (define priests-at-end (distribution-mis (board-end board)))
          (define cannibals-at-end (distribution-can (board-end board))))
    ;; Either priests outnumber cannibals or is 0
    (and (and (or (zero? priests-at-beg) (>= priests-at-beg cannibals-at-beg))
              (<= 0 priests-at-beg MC) (<= 0 cannibals-at-beg MC))
         (and (or (zero? priests-at-end) (>= priests-at-end cannibals-at-end))
              (<= 0 priests-at-end MC) (<= 0 cannibals-at-end MC)))))


;; final-state? : board -> boolean
;; Determines if the board is in a completed stage.
(define (final-state? board)
          (local ((define priests-in-boat (distribution-mis (boat-load (board-boat board))))
          (define cannibals-in-boat (distribution-can (boat-load (board-boat board)))))
     (and (= (distribution-mis (board-beg board)) (distribution-can (board-beg board)) 0)
          (= priests-in-boat cannibals-in-boat 0) 
          (= (distribution-mis (board-end board)) (distribution-can (board-end board)) MC))))

;; final-states : (listof board) -> (listof board)
;; Filters out the final states from a given list of board
(define (final-states boards)
  (filter final-state? boards))
 
;; all-possible-boards : (listof board) -> (listof board)
(define (all-possible-boards boards)
  (foldl append empty (map generate-possible-boards boards)))

;; mc-solvable? : (listof states) -> boolean
;; Caution: Causes infinite loop in case of cycles.
(define (mc-solvable? los)
   (local ((define end (final-states los)))
  (cond
   [(empty? los) false]
   [(cons? end) true]
   [else (mc-solvable? (all-possible-boards los))])))

;; TESTS
(define start (make-board (make-distribution 3 3) (make-boat true (make-distribution 0 0)) (make-distribution 0 0)))
(define end (make-board (make-distribution 0 0) (make-boat false (make-distribution 0 0)) (make-distribution 3 3)))
(mc-solvable? (list start))

;; Note: Though this solution solves all the boards that are solvable
;; it enters in to an infinite loop whenever it's unsolvable due to the
;; presence of cycles in the intermediate generation steps.
