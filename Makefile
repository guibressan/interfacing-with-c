CC = cc
CFLAGS = -O3 -Wextra -Wall

SIMPLE_ADDER_ALL_SRC := \
	simple-adder/src/adder.c
SIMPLE_ADDER_ALL_OBJ := $(patsubst %.c, %.o, $(SIMPLE_ADDER_ALL_SRC))
SIMPLE_ADDER_ALL_HEADER := $(patsubst %.c, %.h, $(SIMPLE_ADDER_ALL_SRC))

SIMPLE_ADDER_TEST_ALL_SRC := \
	simple-adder/test/tests.c
SIMPLE_ADDER_TEST_ALL_OBJ := \
	$(patsubst %.c, %.o, $(SIMPLE_ADDER_TEST_ALL_SRC)) \
	$(SIMPLE_ADDER_ALL_OBJ)
SIMPLE_ADDER_TEST_ALL_BIN := testrunner

.PHONY: all clean

all: simple-adder simple-adder-test interfacing-with-c

# Simple Adder section
simple-adder: $(SIMPLE_ADDER_ALL_OBJ)

simple-adder/src/%.c: $(SIMPLE_ADDER_ALL_HEADER)

# Simple adder test section
simple-adder-test: $(SIMPLE_ADDER_TEST_ALL_BIN)

$(SIMPLE_ADDER_TEST_ALL_BIN): $(SIMPLE_ADDER_TEST_ALL_OBJ)
	$(CC) -o $@: $^

# Interfacing With C Section
interfacing-with-c: FORCE
	@cd interfacing-with-c
	@cargo build
	@cd - 1>/dev/null

%.o: %.c 
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -rf simple-adder/src/*.o
	rm -rf simple-adder/test/testrunner
	rm -rf interfacing-with-c/target

