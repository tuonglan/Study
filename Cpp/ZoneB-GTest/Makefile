
CXX=g++
CC=gcc
CFLAGS=-std=gnu++11 -c -I/opt/gtest/include
LFLAGS=-L/opt/gtest/lib
LIBS=-lgtest -lpthread
TESTFLAG=-D __GTEST_UNIT__

all: run

example.o: example.cc
	$(CXX) $(CFLAGS) $(TESTFLAG) $^ -o $@

%.o: %.cpp
	$(CXX) $(CFLAGS) $< -o $@

run: example.o fixture.o
	$(CXX) $^ -o $@ $(LIBS) $(LFLAGS)

clean:
	rm -f run
	rm *.o -f
