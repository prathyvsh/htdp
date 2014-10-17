#lang racket
(require lang/htdp-intermediate-lambda)

;; An exp is either
;; symbol
;; (Lam symbol exp)
;; or (make-apply exp exp)

;; A Lam is
;; (make-Lam (symbol exp))
(define-struct Lam (var exp))

;; A Apply is
;; (amke-Apply (exp exp)
(define-struct Apply (exp1 exp2))

;; A name-pair is
;; (list symbol symbol)

;; unique-binding : Lam  ->  Lam 
;; To replace variables names of binding occurrences and their bound
;; counterparts so that no name is used twice in a binding occurrence
(define (unique-binding a-lam)
  (new-sym-lam a-lam empty))

;; new-sym-lam : Lam (listof (listof symbol symbol))
;; Replaces symbols in given lambda with unique ones in case
;; of repetition. Accumulator maps the binder variables to their new names.
(define (new-sym-lam a-lam acc)
  (local (;; process-exp : exp (listof (listof symbol symbol))
          (define (process-exp exp acc)
            (cond
             [(symbol? exp) (replacement exp acc)]
             [(Lam? exp) (new-sym-lam exp acc)]
             [(Apply? exp) (new-sym-apply exp acc)]
             [else exp]))
          ;; new-sym-apply : Apply (listof (listof symbol symbol))
          ;; Symbol replacement for Apply
          (define (new-sym-apply exp acc)
            (local ((define exp1 (Apply-exp1 exp))
                    (define exp2 (Apply-exp2 exp)))
              (make-Apply (process-exp exp1 acc) (process-exp exp2 acc))))
          (define exp (Lam-exp a-lam))
          (define var (Lam-var a-lam))
          (define new-name (new-symbol var acc)))
    (make-Lam new-name (process-exp exp (cons (list var new-name) acc)))))

;; get-pair : symbol (listof symbol)
;; Gets the corresponding pair of the symbol from the pair
(define (get-pair sym los)
  (assf (lambda (x) (symbol=? sym x)) los))

;; new-symbol : symbol (listof (listof symbol symbol))
;; Creates a new symbol using gensym if the symbol
;; is not present
(define (new-symbol sym pairs)
  (cond
   [(boolean? (get-pair sym pairs)) sym]
   [else (gensym sym)]))

;; replace-symbol : symbol (listof (listof symbol symbol))
;; Gives back the corresponding pair 
(define (replacement sym pairs)
  (cond
   [(boolean? (get-pair sym pairs)) sym]
   [else (second (get-pair sym pairs))]))

;; TESTS
(define lamb-free-x (make-Lam 'x (make-Lam 'x (make-Lam 'x 'x))))
(define lamb-free-x2 (make-Lam 'x (make-Lam 'x (make-Apply (make-Lam 'x 'x) 'x))))
(define lamb-apply-y (make-Lam 'y (make-Lam 'y (make-Apply (make-Lam 'q 'x) (make-Lam 'x 'y)))))

(unique-binding lamb-free-x)
(unique-binding lamb-free-x2)
(unique-binding lamb-apply-y)
