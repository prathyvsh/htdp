#|
1. (define (f x) (begin (set! y x) x))
;; Illegal since y is not defined.

2. (define (f x) (begin (set! f x) x))
;; Legal

3. (local ((define-struct hide (it))
	     (define make-hide 10))
       (hide? 10))
;; Illegal. Cannot redeclare make-hide which
;; is automatically gets added to the
;; namespace with define-struct.

4. (local ((define-struct loc (con))
	     (define loc 10))
       (loc? 10))
;; Illegal. Cannot redeclare struct name.

5. (define f (lambda (x y x) (* x y z)))
   (define z 3.14)
;; Illegal. Duplicate parameter x.
|#
