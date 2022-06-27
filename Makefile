PREFIX = $(HOME)
LIB_DIR = $(PREFIX)/lib
INC_DIR = $(PREFIX)/include
DATA_DIR = $(PREFIX)/share/igrf

LIB_SUFFIX = _18
TARGET = libigrf$(LIB_SUFFIX).so

OBJS = geomag70.o
OPTS = -O3 -Wall -fPIC

all: libigrf$(LIB_SUFFIX).so

libigrf$(LIB_SUFFIX).so: $(OBJS)
	g++ -shared -o $@ $(OBJS)

geomag70.o: geomag70.cpp geomag.h
	g++ -c $< $(OPTS) -DDATA_DIR=\"$(DATA_DIR)/\"

test: main.o
	g++ -o $@ main.o -Wl,-R$(LIB_DIR) -L$(LIB_DIR) -ligrf$(LIB_SUFFIX)

main.o: main.cpp
	g++ -c $< -I$(INC_DIR)

install: $(TARGET)
	cp $(TARGET) $(LIB_DIR)
	cp geomag.h $(INC_DIR)
	@if [ ! -d $(DATA_DIR) ]; then \
	mkdir -p $(DATA_DIR); \
	fi
	cp IGRF13.COF $(DATA_DIR)

clean:
	rm -rf $(TARGET) *.o test
