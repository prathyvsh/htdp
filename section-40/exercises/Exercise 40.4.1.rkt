(define X (vector 0 0 0 0))

(define Y X)

(begin
  (vector-set! X 0 2)
  (vector-set! Y 1 (+ (vector-ref Y 0) (vector-ref Y 1)))
  (vector-ref Y 1))

;;

(define X (vector 0 0 0 0))

(define Y X)

(begin
  (vector-set! (vector 0 0 0 0) 0 2)
  (vector-set! Y 1 (+ (vector-ref Y 0) (vector-ref Y 1)))
  (vector-ref Y 1))

;;

(define X (vector 2 0 0 0))

(define Y X)

(begin
  (void)
  (vector-set! Y 1 (+ (vector-ref Y 0) (vector-ref Y 1)))
  (vector-ref Y 1))

;;

(define X (vector 2 0 0 0))

(define Y X)

(begin
  (void)
  (vector-set! (vector 2 0 0 0) 1 (+ (vector-ref Y 0) (vector-ref Y 1)))
  (vector-ref Y 1))

;; 

(define X (vector 2 0 0 0))

(define Y X)

(begin
  (void)
  (vector-set! (vector 2 0 0 0) 1 (+ (vector-ref (vector-ref 2 0 0 0) 0) (vector-ref Y 1)))
  (vector-ref Y 1))

;;

(define X (vector 2 0 0 0))

(define Y X)

(begin
  (void)
  (vector-set! (vector 2 0 0 0) 1 (+ 2 (vector-ref Y 1)))
  (vector-ref Y 1))

;;

(define X (vector 2 0 0 0))

(define Y X)

(begin
  (void)
  (vector-set! (vector 2 0 0 0) 1 (+ 2 (vector-ref (vector 2 0 0 0) 1)))
  (vector-ref Y 1))

;;

(define X (vector 2 0 0 0))

(define Y X)

(begin
  (void)
  (vector-set! (vector 2 0 0 0) 1 (+ 2 0))
  (vector-ref Y 1))

;;

(define X (vector 2 0 0 0))

(define Y X)

(begin
  (void)
  (vector-set! (vector 2 0 0 0) 1 2) (vector-ref Y 1))

;;

(define X (vector 2 0 0 0))

(define Y X)

(begin
  (void)
  (vector-set! (vector 2 0 0 0) 1 2) (vector-ref Y 1))

;;

(define X (vector 2 0 0 0))

(define Y (vector 2 2 0 0))

(begin
  (void) (void) (vector-ref Y 1))

;;

(define X (vector 2 0 0 0))

(define Y (vector 2 2 0 0))

(begin
  (void) (void) (vector-ref (vector 2 2 0 0) 1))

;;

(define X (vector 2 0 0 0))

(define Y (vector 2 2 0 0))

(begin (void) (void) 2)

;;

(define X (vector 2 0 0 0))

(define Y (vector 2 2 0 0))

1

