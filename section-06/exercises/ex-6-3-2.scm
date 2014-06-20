(define-struct movie (title producer))

(movie-title (make-movie 'ThePhantomMenace 'Lucas))
;; 'ThePhantomMenace
(movie-producer (make-movie 'TheEmpireStrikesBack 'Lucas))
;; 'Lucas
(movie-title (make-movie x y))
;; 'x
(movie-producer (make-movie x y))
;; 'y

;; Equation stating relationship
(define any-movie (make-movie 'any-title 'any-producer)) = (make-movie (movie-title any-movie) (movie-producer any-movie))
