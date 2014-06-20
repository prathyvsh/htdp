;; A movie is a structure:
;; (make-movie symbol symbol)
(define-struct movie (title producer))
;; A boyfriend is a structure:
;; (make-boyfriend symbol symbol symbol symbol)
(define-struct boyfriend (name hair eyes phone))
;; A cheerleader is a structure:
;; (make-cheerleader symbol symbol)
(define-struct cheerleader (name number))
;; A CD is a structure:
;; (make-CD symbol symbol number)
(define-struct CD (artist title price))
;; A sweater is a structure:
;; (make-sweater symbol number symbol)
(define-struct sweater (material size producer))
