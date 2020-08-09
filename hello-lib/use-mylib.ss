(import (mylib))

; call function from C shared lib and return pointer
(define c
  (makeCoord 10101 22222))

; print C pointer value
(printf "c: ~a\n" c)

; extract & print values from C pointer
(define x
  (foreign-ref 'int c 0))
(define y
  (foreign-ref 'int c (foreign-sizeof 'int)))
(printf "foreign-ref... x: ~a, y: ~a\n" x y)

; call free function from C shared lib - free C pointer
(freeCoord c)
; illegal access after free - values no longer available
(define x1
  (foreign-ref 'int c 0))
(define y1
  (foreign-ref 'int c (foreign-sizeof 'int)))
(printf "foreign-ref... x1: ~a, y1: ~a\n" x1 y1)


; call C function returning foreign type defined in scheme
(define c1
  (mc 11 22))

; print foreign type as S-expression and print references from it's structure
(printf "ftype-pointer->sexpr... c1: ~a\n" (ftype-pointer->sexpr c1))
(printf "ftype, x: ~a, y: ~a\n" (ftype-ref coord_t (x) c1) (ftype-ref coord_t (y) c1))

; call free function from C shared lib - free C pointer
(fc c1)
; illegal access after free - values no longer available
(printf "ftype-pointer->sexpr... c1: ~a\n" (ftype-pointer->sexpr c1))

(exit)
