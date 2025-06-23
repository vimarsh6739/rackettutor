#lang br/quicklang

(define (read-syntax path port)
  (define src-lines (port->lines port))
  (define src-datums (format-datums '(handle ~a) src-lines))
  (define module-datum
    `(module stacker-mod "stacker.rkt"
       ,@src-datums))
  (datum->syntax #f module-datum))
(provide read-syntax)

;; define expander macro
(define-macro (stacker-module-begin HANDLE-EXPR ...) 
  #'(#%module-begin HANDLE-EXPR ...
     (display (first stack))))
(provide (rename-out [stacker-module-begin #%module-begin]))

;; define stack ops
(define stack empty)

;; read 1st element, pop 
(define (pop-stack!)
  (define arg (first stack))
  (set! stack (rest stack))
  arg)

;; prepend element
(define (push-stack! arg)
  (set! stack (cons arg stack)))

;; define handler
(define (handle [arg #f])
  (cond 
    [(number? arg) (push-stack! arg)]
    [(or (equal? + arg) (equal? * arg))
     (define op-result (arg (pop-stack!) (pop-stack!)))
     (push-stack! op-result)]))

(provide handle)
;; provide bindings for + and *
(provide + *)
