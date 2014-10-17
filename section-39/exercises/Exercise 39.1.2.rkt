(define lights
  (list (make-traffic-light 'sunrise@rice 50)
        (make-traffic-light 'sunrise@cmu 150)))

;; definitions for 'sunrise@rice
(define current-color@rice 'red)

(define (init-traffic-light@rice) 
  (begin (set! current-color@rice 'red)
         (draw-light current-color@rice 50)))

(define (next@rice)
  (begin (set! current-color@rice (next-color current-color@rice))
         (draw-light current-color@rice 50)))

(define (next-color@rice current-color)
  (cond
   [(symbol=? 'green current-color) 'yellow]
   [(symbol=? 'yellow current-color) 'red]
   [(symbol=? 'red current-color) 'green]))

(begin (init-traffic-light@rice) next@rice)

;; definitions for 'sunrise@cmu
(define current-color@cmu 'red)

(define (init-traffic-light@cmu) 
  (begin (set! current-color@cmu 'red)
         (draw-light current-color@cmu 150)))

(define (next@cmu)
  (begin (set! current-color@cmu (next-color current-color@cmu))
         (draw-light current-color@cmu 150)))

(define (next-color@cmu current-color)
  (cond
   [(symbol=? 'green current-color) 'yellow]
   [(symbol=? 'yellow current-color) 'red]
   [(symbol=? 'red current-color) 'green]))

(begin (init-traffic-light@cmu) next@cmu)

;;

((second lights)) ;;evaluates as

((begin (init-traffic-light@cmu) next@cmu))

;; 

(define current-color@cmu 'red)

((begin (begin (set! current-color@cmu 'red) (draw-light current-color@cmu 150))
         next@cmu))
  

;;

(define current-color@cmu 'red)
((begin (begin (void) (void)) next@cmu))

;;

(define current-color@cmu 'red)
(next@cmu)

;;

(define current-color@cmu 'red)
(begin (set! current-color@cmu (next-color 'red)) (draw-light current-color@cmu 150)))

;;

(define current-color@cmu 'red)
(begin (set! current-color@cmu 'green) (draw-light current-color@cmu 150)))

;;

(define current-color@cmu 'green)
(begin (void) (draw-light 'green 150))

;;

(define current-color@cmu 'green)
(void)
