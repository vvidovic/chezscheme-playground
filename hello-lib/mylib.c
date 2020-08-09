#include <stdlib.h>
#include <stdio.h>

typedef struct coord_s coord_t;

struct coord_s {
  int x;
  int y;
};

coord_t* makeCoord(int x, int y) {
  fprintf(stdout, "makeCoord(%d, %d)\n", x, y);
  struct coord_s *p = malloc(sizeof(struct coord_s));

  p->x = x;
  p->y = y;

  return p;
}

void freeCoord(coord_t* c) {
  fprintf(stdout, "freeCoord(%d, %d)\n", c->x, c->y);
  free(c);
}

typedef void (*use_data_cb)(const char* data);
typedef void (*use_coord_cb)(coord_t* coord);

void doWithData(const char* data, use_data_cb callback) {
// void doWithData(char* data) {
  fprintf(stdout, "doWithData(%s, ..)\n", data);
  callback(data);
}

void doWithCoord(coord_t* coord, use_coord_cb callback) {
  fprintf(stdout, "doWithCoord(%d, %d, ..)\n", coord->x, coord->y);
  callback(coord);
}
