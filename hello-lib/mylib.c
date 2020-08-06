#include <stdlib.h>

typedef struct coord_s coord_t;

struct coord_s {
  int x;
  int y;
};

coord_t* makeCoord(int x, int y) {
  struct coord_s *p = malloc(sizeof(struct coord_s));

  p->x = x;
  p->y = y;

  return p;
}

void freeCoord(coord_t* c) {
  free(c);
}
