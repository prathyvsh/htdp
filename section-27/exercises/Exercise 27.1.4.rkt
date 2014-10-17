#lang racket
(require htdp/draw)
(require lang/htdp-intermediate-lambda)

;; A line is
;; (make-line posn posn color)
(define-struct line (start angle length color))
(define-struct drawable-line (start end color))

;; savannah-tree : line -> true
(define (savannah-tree l)
  (local ((define one-third (fractions 1/3 l))
          (define two-third (fractions 2/3 l))
          (define original-length (line-length l))
          (define span-angle 15)
          (define branch-right (make-line one-third (+ (line-angle l) span-angle) (* 1/2 original-length) (line-color l)))
          (define branch-left (make-line two-third (- (line-angle l) span-angle) (* 1/2 original-length) (line-color l)))
          (define original (line->drawable-line l)))
    (cond [(< original-length 4) true]
          [else (and (draw-solid-line (drawable-line-start original)
                                      (drawable-line-end original)
                                      (drawable-line-color original))
                     (savannah-tree branch-left)
                     (savannah-tree branch-right))])))

;; flipped-end-point : line -> posn
;; Gets the end posn of line
(define (flipped-end-point line)
  (make-posn (+ (posn-x (line-start line))
                (* (line-length line) (sin (+ pi (* pi (/ (line-angle line) 180))))))
             (+ (posn-y (line-start line))
                (* (line-length line) (cos (+ pi (* pi (/ (line-angle line) 180))))))))

;; fractions : line -> posn
;; Computes the third posn on the line
(define (fractions factor line)
  (local ((define x1 (posn-x (line-start line)))
          (define y1 (posn-y (line-start line)))
          (define x2 (posn-x (flipped-end-point line)))
          (define y2 (posn-y (flipped-end-point line))))
    (make-posn (+ x1 (* factor (- x2 x1)))
               (+ y1 (* factor (- y2 y1))))))

;; line->drawable-line : start rotation length
(define (line->drawable-line line)
  (make-drawable-line (line-start line) (flipped-end-point line) (line-color line)))

;; TESTS
(start 300 300)
(define l (make-line (make-posn 100 300) 0 150 'black))
(savannah-tree l)
