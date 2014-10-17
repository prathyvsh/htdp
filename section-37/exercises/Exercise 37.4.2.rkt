#lang racket
(require htdp/gui)
(require lang/htdp-advanced)

;; DATA DEFINITION

;; A task is a string

;; A task queue is a list of tasks

;; STATE VARIABLES

;; tasks : (listof tasks)
;; Keeps track of the remaining tasks
(define tasks empty)

;; add-task : task -> void
;; Adds a new task to the tasks variable
(define (add-task t)
  (set! tasks (cons t tasks)))

;; next-task -> void
;; Gets the first element from the tasks.
(define (next-task) (first tasks))

;; remove-task -> void
;; Takes out the rest of the tasks from
;; the task list.
(define (remove-task)
  (set! tasks (rest tasks)))

;; count-tasks -> string
;; Gives the count of number of tasks
;; remaining
(define (count-tasks)
  (number->string (length tasks)))


;; CONTROLLER

;; enter-tasks : e -> void
;; Enters a given task into the task list
;; Effect: Adds task to task list
(define (enter-task e)
  (begin (log-task (text-contents task-field))
         (display-count)))

;; log-task : task -> void
;; Adds a task on to the task list
(define (log-task t)
  (cond
    [(string=? "" t) (draw-message task-display "Please enter a task name.")]
    [else (add-task t)]))

;; display-status -> void
;; Displays the current state of the UI
(define (display-status)
  (begin (cond
           [(more-tasks?) (draw-message task-display (next-task))]
           [else (draw-message task-display "No more tasks left.")])
         (display-count)))

;; display-count -> void
;; Displays the current count of tasks
(define (display-count)
  (draw-message task-count-display (count-tasks)))

;; more-tasks? -> boolean
;; Determines if there's remaining tasks
(define (more-tasks?) (not (= (length tasks) 0)))

;; show-next-task : event -> void
;; Displays the next task
(define (show-next-task e)
  (cond
   [(more-tasks?) (begin (remove-task) (display-status))]
   [else (display-status)]))

;; VIEW

(define task-display (make-message "Welcome to the Task Manager"))
(define task-count-display (make-message "2014"))
(define enter-button (make-button "Enter" enter-task))
(define next-button (make-button "Next" show-next-task))
(define quit-button (make-button "Quit" (lambda (x) (hide-window window))))
(define task-field (make-text "Task:"))
(define window (create-window (list (list task-display task-count-display)
                       (list task-field enter-button)
                       (list next-button quit-button))))
(define (start-task-manager) (begin (set! tasks empty) window))
                             
;; TESTS
(start-task-manager)
