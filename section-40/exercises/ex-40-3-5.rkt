(define-struct CD (artist title price))

(define in-stock
  (list
    ((make-CD 'R.E.M "New Adventures in Hi-fi" 0)
     (make-CD 'France "simple je" 0)
     (make-CD 'Cranberries "no need to argue" 0))))

(begin
  (set-CD-price! (first in-stock) 12)
  (set-CD-price! (second in-stock) 19)
  (set-CD-price! (third in-stock) 11)
  (+ (CD-price (first in-stock))
     (CD-price (second in-stock))
     (CD-price (third in-stock))))

;;

(define-struct CD (artist title price))

(define r (make-CD 'R.E.M "New Adventures in Hi-fi" 0))
(define f (make-CD 'France "simple je" 0))
(define c (make-CD 'Cranberries "no need to argue" 0))

(define in-stock (list r f c))

(begin
  (set-CD-price! (first in-stock) 12)
  (set-CD-price! (second in-stock) 19)
  (set-CD-price! (third in-stock) 11)
  (+ (CD-price (first in-stock))
     (CD-price (second in-stock))
     (CD-price (third in-stock))))

;;

(define-struct CD (artist title price))

(define r (make-CD 'R.E.M "New Adventures in Hi-fi" 0))
(define f (make-CD 'France "simple je" 0))
(define c (make-CD 'Cranberries "no need to argue" 0))

(define in-stock (list r f c))

(begin (set-CD-price! (first (list r f c)) 12)
  (set-CD-price! (second in-stock) 19)
  (set-CD-price! (third in-stock) 11)
  (+ (CD-price (first in-stock))
     (CD-price (second in-stock))
     (CD-price (third in-stock))))

;;

(define-struct CD (artist title price))

(define r (make-CD 'R.E.M "New Adventures in Hi-fi" 0))
(define f (make-CD 'France "simple je" 0))
(define c (make-CD 'Cranberries "no need to argue" 0))

(define in-stock (list r f c))

(begin (set-CD-price! r 12)
  (set-CD-price! (second in-stock) 19)
  (set-CD-price! (third in-stock) 11)
  (+ (CD-price (first in-stock))
     (CD-price (second in-stock))
     (CD-price (third in-stock))))

;;

(define-struct CD (artist title price))

(define r (make-CD 'R.E.M "New Adventures in Hi-fi" 12))
(define f (make-CD 'France "simple je" 0))
(define c (make-CD 'Cranberries "no need to argue" 0))

(define in-stock (list r f c))

(begin (void)
  (set-CD-price! (second in-stock) 19)
  (set-CD-price! (third in-stock) 11)
  (+ (CD-price (first in-stock))
     (CD-price (second in-stock))
     (CD-price (third in-stock))))

;;

(define-struct CD (artist title price))

(define r (make-CD 'R.E.M "New Adventures in Hi-fi" 12))
(define f (make-CD 'France "simple je" 0))
(define c (make-CD 'Cranberries "no need to argue" 0))

(define in-stock (list r f c))

(begin (void)
  (set-CD-price! (second (list r f c)) 19)
  (set-CD-price! (third in-stock) 11)
  (+ (CD-price (first in-stock))
     (CD-price (second in-stock))
     (CD-price (third in-stock))))

;;

(define-struct CD (artist title price))

(define r (make-CD 'R.E.M "New Adventures in Hi-fi" 12))
(define f (make-CD 'France "simple je" 0))
(define c (make-CD 'Cranberries "no need to argue" 0))

(define in-stock (list r f c))

(begin (void)
  (set-CD-price! f 19)
  (set-CD-price! (third in-stock) 11)
  (+ (CD-price (first in-stock))
     (CD-price (second in-stock))
     (CD-price (third in-stock))))

;;

(define-struct CD (artist title price))

(define r (make-CD 'R.E.M "New Adventures in Hi-fi" 12))
(define f (make-CD 'France "simple je" 19))
(define c (make-CD 'Cranberries "no need to argue" 0))

(define in-stock (list r f c))

(begin (void) (void)
  (set-CD-price! (third in-stock) 11)
  (+ (CD-price (first in-stock))
     (CD-price (second in-stock))
     (CD-price (third in-stock))))

;;

(define-struct CD (artist title price))

(define r (make-CD 'R.E.M "New Adventures in Hi-fi" 12))
(define f (make-CD 'France "simple je" 19))
(define c (make-CD 'Cranberries "no need to argue" 0))

(define in-stock (list r f c))

(begin (void) (void)
  (set-CD-price! (third in-stock) 11)
  (+ (CD-price (first in-stock))
     (CD-price (second in-stock))
     (CD-price (third in-stock))))

;;

(define-struct CD (artist title price))

(define r (make-CD 'R.E.M "New Adventures in Hi-fi" 12))
(define f (make-CD 'France "simple je" 19))
(define c (make-CD 'Cranberries "no need to argue" 0))

(define in-stock (list r f c))

(begin (void) (void)
  (set-CD-price! (third (list r f c)) 11)
  (+ (CD-price (first in-stock))
     (CD-price (second in-stock))
     (CD-price (third in-stock))))

;;

(define-struct CD (artist title price))

(define r (make-CD 'R.E.M "New Adventures in Hi-fi" 12))
(define f (make-CD 'France "simple je" 19))
(define c (make-CD 'Cranberries "no need to argue" 0))

(define in-stock (list r f c))

(begin (void) (void)
  (set-CD-price! c 11)
  (+ (CD-price (first in-stock))
     (CD-price (second in-stock))
     (CD-price (third in-stock))))

;;

(define-struct CD (artist title price))

(define r (make-CD 'R.E.M "New Adventures in Hi-fi" 12))
(define f (make-CD 'France "simple je" 19))
(define c (make-CD 'Cranberries "no need to argue" 11))

(define in-stock (list r f c))

(begin (void) (void) (void)
  (+ (CD-price (first in-stock))
     (CD-price (second in-stock))
     (CD-price (third in-stock))))

;;

(define-struct CD (artist title price))

(define r (make-CD 'R.E.M "New Adventures in Hi-fi" 12))
(define f (make-CD 'France "simple je" 19))
(define c (make-CD 'Cranberries "no need to argue" 11))

(define in-stock (list r f c))

(begin (void) (void) (void)
  (+ (CD-price (first in-stock))
     (CD-price (second in-stock))
     (CD-price (third in-stock))))

;;

(define-struct CD (artist title price))

(define r (make-CD 'R.E.M "New Adventures in Hi-fi" 12))
(define f (make-CD 'France "simple je" 19))
(define c (make-CD 'Cranberries "no need to argue" 11))

(define in-stock (list r f c))

(begin (void) (void) (void)
  (+ (CD-price (first (list r f c)))
     (CD-price (second in-stock))
     (CD-price (third in-stock))))

;;

(define-struct CD (artist title price))

(define r (make-CD 'R.E.M "New Adventures in Hi-fi" 12))
(define f (make-CD 'France "simple je" 19))
(define c (make-CD 'Cranberries "no need to argue" 11))

(define in-stock (list r f c))

(begin (void) (void) (void)
  (+ (CD-price r)
     (CD-price (second in-stock))
     (CD-price (third in-stock))))

;;

(define-struct CD (artist title price))

(define r (make-CD 'R.E.M "New Adventures in Hi-fi" 12))
(define f (make-CD 'France "simple je" 19))
(define c (make-CD 'Cranberries "no need to argue" 11))

(define in-stock (list r f c))

(begin (void) (void) (void)
  (+ 12 (CD-price (second in-stock))
     (CD-price (third in-stock))))

;;

(define-struct CD (artist title price))

(define r (make-CD 'R.E.M "New Adventures in Hi-fi" 12))
(define f (make-CD 'France "simple je" 19))
(define c (make-CD 'Cranberries "no need to argue" 11))

(define in-stock (list r f c))

(begin (void) (void) (void)
  (+ 12 (CD-price (second (list r f c))
     (CD-price (third in-stock)))))

;;

(define-struct CD (artist title price))

(define r (make-CD 'R.E.M "New Adventures in Hi-fi" 12))
(define f (make-CD 'France "simple je" 19))
(define c (make-CD 'Cranberries "no need to argue" 11))

(define in-stock (list r f c))

(begin (void) (void) (void)
  (+ 12 (CD-price f)
     (CD-price (third in-stock)))))

;;

(define-struct CD (artist title price))

(define r (make-CD 'R.E.M "New Adventures in Hi-fi" 12))
(define f (make-CD 'France "simple je" 19))
(define c (make-CD 'Cranberries "no need to argue" 11))

(define in-stock (list r f c))

(begin (void) (void) (void)
  (+ 12 19 (CD-price (third in-stock)))))

;;

(define-struct CD (artist title price))

(define r (make-CD 'R.E.M "New Adventures in Hi-fi" 12))
(define f (make-CD 'France "simple je" 19))
(define c (make-CD 'Cranberries "no need to argue" 11))

(define in-stock (list r f c))

(begin (void) (void) (void)
  (+ 12 19 (CD-price (third (list r f c)))))

;;

(define-struct CD (artist title price))

(define r (make-CD 'R.E.M "New Adventures in Hi-fi" 12))
(define f (make-CD 'France "simple je" 19))
(define c (make-CD 'Cranberries "no need to argue" 11))

(define in-stock (list r f c))

(begin (void) (void) (void)
  (+ 12 19 (CD-price c)))

;;

(define-struct CD (artist title price))

(define r (make-CD 'R.E.M "New Adventures in Hi-fi" 12))
(define f (make-CD 'France "simple je" 19))
(define c (make-CD 'Cranberries "no need to argue" 11))

(define in-stock (list r f c))

(begin (void) (void) (void) (+ 12 19 11))

;;

(define-struct CD (artist title price))

(define r (make-CD 'R.E.M "New Adventures in Hi-fi" 12))
(define f (make-CD 'France "simple je" 19))
(define c (make-CD 'Cranberries "no need to argue" 11))

(define in-stock (list r f c))

(begin (void) (void) (void) (+ 12 19 11))

;;

(define-struct CD (artist title price))

(define r (make-CD 'R.E.M "New Adventures in Hi-fi" 12))
(define f (make-CD 'France "simple je" 19))
(define c (make-CD 'Cranberries "no need to argue" 11))

(define in-stock (list r f c))

(begin (void) (void) (void) 42)

;;

42
