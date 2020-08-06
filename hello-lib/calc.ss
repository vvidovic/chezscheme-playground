(library (calc)
  (export
    add
    sub)
  (import (chezscheme))

  (define (add x y)
    (+ x y))

  (define sub
    (lambda (x y)
      (- x y))))
