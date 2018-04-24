CXX = g++
CFLAGS = -O1 -Wall -g
SRCS = matadd.s matadd-driver.s
BIN = matadd

all:
	$(CXX) $(CFLAGS) -o $(BIN) $(SRCS)

clean:
	rm -f $(BIN)
