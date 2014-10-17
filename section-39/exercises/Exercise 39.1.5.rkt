#|
;; lights : (listof traffic-light)
;; to manage the lights along Sunrise 
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

(define (service-manager@rice msg)
  (cond
   [(symbol=? msg 'next) (next@rice)]
   [(symbol=? msg 'reset) (init-traffic-light@rice)]
   [else (error 'traffic-light "message not understood")])))

(define (next-color@rice current-color)
  (cond
   [(symbol=? 'green current-color) 'yellow]
   [(symbol=? 'yellow current-color) 'red]
   [(symbol=? 'red current-color) 'green]))


(begin (init-traffic-light@rice) service-manager)

;;

((second lights) 'next) 
(andmap (lambda (a-light) (a-light 'reset)) lights)

;; 

(((((begin (init-traffic-light@rice) service-manager)) 'next) 'next) 'next)
(andmap (lambda (a-light) (a-light 'reset)) lights)

;; 

(define current-color@rice 'red)

(((begin (begin (set! current-color@rice 'red) (draw-light current-color@rice 150))
         service-manager)) 'next)
(andmap (lambda (a-light) (a-light 'reset)) lights)

;;

(define current-color@rice 'red)
(((begin (begin (void) (void))
         service-manager)) 'next)
(andmap (lambda (a-light) (a-light 'reset)) lights)

;;

(define current-color@rice 'red)
(service-manager 'next)
(andmap (lambda (a-light) (a-light 'reset)) lights)

;;

(define current-color@rice 'red)
(next@rice)
(andmap (lambda (a-light) (a-light 'reset)) lights)

;;

(define current-color@rice 'red)
((begin (set! current-color@rice 'green) (draw-light current-color@rice 150)))
(andmap (lambda (a-light) (a-light 'reset)) lights)

;;

(define current-color@rice 'green)
(void)
(andmap (lambda (a-light) (a-light 'reset)) lights)

;;

(define current-color@rice 'green)

(cond
 [(symbol=? 'reset 'next) (next@rice)]
 [(symbol=? msg 'reset) (init-traffic-light@rice)]
 [else (error 'traffic-light "message not understood")])))

;;

(define current-color@rice 'green)
(init-traffic-light@rice)

;;

(define current-color@rice 'green)
(init-traffic-light@rice)

;; 

(define current-color@rice 'green)
(begin (set! current-color@rice 'red)
       (draw-light current-color@rice 50))

;;
(define current-color@rice 'red)
(void)

|#
