The administrators of metropolitan transportation agencies manage fleets of vehicles. Develop structure and data definitions for a collection of such vehicles. The collection should include at least buses, limos, cars, and subways. Add at least two attributes per class of vehicle.

Then develop a template for functions that consume vehicles.

;; A vehicle is either:
;; make-buse number number number
;; make-limo boolean number
;; make-car boolean number
;; make-subway number number

(define-struct bus (tyres speed max-weight))
(define-struct limo (escort? speed))
(define-struct car (taxi? speed))
(define-struct subway (boggies speed))

;; TEMPLATE
;; vehicle-manipulation : vehicle -> ???
;(define (vehicle-manipulation vehicle)
  ;(cond
    ;[(bus? vehicle) ... (bus-tyres) ... (bus-speed) ... (bus-max-weight) ...]
    ;[(limo? vehicle) ... (limo-escort? vehicle) ... (limo-speed speed) ...]
    ;[(car? vehicle) ... (car-taxi? vehicle) ...(car-speed vehicle) ...]
    ;[(subway? vehicle) ... (boggies vehicle) ... (subway-speed) ...]
    ;))
