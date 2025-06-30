#lang racket

(for/fold ([sum 0]) ([int (list 1 2 3 4 5 6 7 8 9)])
  (+ sum int))
