#include "../src/adder.h"
#include <stdio.h>
#include <stdlib.h>

void test_runner(void);
void adder_test(void);
void assert(int result);

int main(void) {
  test_runner();
}

void test_runner(void) {
  adder_test();
}

void assert(int result){
  if (!result) {
    fprintf(stderr, "Assertion failed");
    exit(1);
  }
}

void adder_test(void) {
  printf("Running: adder_test\n");
  int x = 1;
  int y = 3;
  int exp = 4;

  assert(add(x,y) == exp);
  printf("Pass: adder_test\n");
}

