#lang racket
(require br/macro)
;; simple for loop with fold(l)
(for/fold ([sum 0]) ([int (list 1 2 3 4 5 6 7 8 9)])
  (+ sum int))

;; messing around with ...
;; ... is a placeholder for ARG here 
(define-macro (lister ARG ...)
  #'(list ARG ...))

(lister "foo" "bar" "baz")
; '("foo" "bar" "baz")

(define-macro (wrap ARG ...)
  #'(list '(ARG 42) ...))

(wrap "foo" "bar" "baz")
; '(("foo" 42) ("bar" 42) ("baz" 42))

(define-macro (wrap2 ARG ...)
  #'(list '(ARG 42 ARG) ...))

(wrap2 "foo" "bar" "baz")
; '(("foo" 42 "foo") ("bar" 42 "bar") ("baz" 42 "baz"))
