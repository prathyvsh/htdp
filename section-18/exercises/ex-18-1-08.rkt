#lang racket
(require htdp/draw)
(require lang/htdp-intermediate)

;; draw-polygon : polygon  ->  true
;; to draw the polygon specified by a-poly 
(define (draw-polygon a-poly)
  (local (
          ;; connect-dots : polygon  ->  true
          ;; to draw connections between the dots of a-poly
          (define (connect-dots a-poly)
            (cond
             [(empty? (rest a-poly)) true]
             [else (and (draw-solid-line (first a-poly) (second a-poly) 'black)
                        (connect-dots (rest a-poly)))]))
          ;; last : polygon  ->  posn
          ;; to extract the last posn on a-poly
          (define (last a-poly)
            (cond
             [(empty? (rest a-poly)) (first a-poly)]
             [else (last (rest a-poly))])))
  (connect-dots (cons
                 (last a-poly) a-poly))))

;; TESTS
(start 300 300)
(define poly (list (make-posn 100 20) (make-posn 20 40) (make-posn 40 60) (make-posn 100 60)))
(draw-polygon poly)
