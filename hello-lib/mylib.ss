; compile mylib.c to shared lib using: cc -shared mylib.c -o mylib.so
(library (mylib)
  (export
    makeCoord
    freeCoord
    coord_t
    mc
    fc)
  (import (chezscheme))

  ; load shared library in scheme
  (define lib (load-shared-object "./mylib.so"))

  ; prepare functions from C shared lib - define as foreign procedures
  (define makeCoord
    (foreign-procedure "makeCoord" (int int) uptr))
  (define freeCoord
    (foreign-procedure "freeCoord" (uptr) void))


  ; define type to which we can map C type
  (define-ftype coord_t
    (struct
     [x int]
     [y int]))
  ; prepare C functions using foreign type defined in scheme
  (define mc
   (foreign-procedure "makeCoord" (int int) (* coord_t)))
  ; (define fc
  ;  (foreign-procedure "freeCoord" (uptr) void))
  (define fc
   (foreign-procedure "freeCoord" ((* coord_t)) void))

)
