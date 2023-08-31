CC = cc
CFLAGS = -O3 -Wextra -Wall
AR = ar -rcs

SIMPLE_ADDER_ALL_SRC := \
	simple-adder/src/adder.c
SIMPLE_ADDER_ALL_OBJ := $(patsubst %.c, %.o, $(SIMPLE_ADDER_ALL_SRC))
SIMPLE_ADDER_ALL_HEADER := $(patsubst %.c, %.h, $(SIMPLE_ADDER_ALL_SRC))
SIMPLE_ADDER_ALL_SLIB := simple-adder/src/libadder.a

SIMPLE_ADDER_TEST_ALL_SRC := \
	simple-adder/test/tests.c
SIMPLE_ADDER_TEST_ALL_OBJ := \
	$(patsubst %.c, %.o, $(SIMPLE_ADDER_TEST_ALL_SRC))
SIMPLE_ADDER_TEST_ALL_BIN := \
	simple-adder/test/testrunner

.PHONY: all clean

all: simple-adder simple-adder-test interfacing-with-c

# Simple Adder section
simple-adder: $(SIMPLE_ADDER_ALL_SLIB) 

$(SIMPLE_ADDER_ALL_SLIB): $(SIMPLE_ADDER_ALL_OBJ)
	$(AR) $@ $^

simple-adder/src/%.c: $(SIMPLE_ADDER_ALL_HEADER)

# Simple adder test section
simple-adder-test: $(SIMPLE_ADDER_TEST_ALL_BIN)

$(SIMPLE_ADDER_TEST_ALL_BIN): $(SIMPLE_ADDER_TEST_ALL_OBJ)
	$(CC) $(CFLAGS) -o $@ -Lsimple-adder/src -ladder $^

# Interfacing With C Section
interfacing-with-c: FORCE
	cargo build --package interfacing-with-c

%.o: %.c 
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -rf simple-adder/src/*.o
	rm -rf simple-adder/src/*.a
	rm -rf simple-adder/test/*.o
	rm -rf simple-adder/test/testrunner
	rm -rf target

FORCE:

