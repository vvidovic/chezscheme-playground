; compile mylib.c to shared lib using: cc -shared mylib.c -o mylib.so

; load shared library in scheme
(define lib (load-shared-object "./mylib.so"))

; prepare functions from C shared lib - define as foreign procedures
(define makeCoord
  (foreign-procedure "makeCoord" (int int) uptr))
(define freeCoord
  (foreign-procedure "freeCoord" (uptr) void))

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

; define type to which we can map C type
(define-ftype coord_t
  (struct
   [x int]
   [y int]))
; prepare C functions using foreign type defined in scheme
(define mc
 (foreign-procedure "makeCoord" (int int) (* coord_t)))
(define fc
 (foreign-procedure "freeCoord" (uptr) void))
(define fc
 (foreign-procedure "freeCoord" ((* coord_t)) void))
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
