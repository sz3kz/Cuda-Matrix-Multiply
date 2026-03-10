#include "../../include/interractive.h"

unsigned int interractive::calculateWidth(int random_upper_limit){
  unsigned int width = 1;
  random_upper_limit--;
  do {
    width++;
    random_upper_limit /= 10;
  } while (random_upper_limit > 0);
  return width;
}
