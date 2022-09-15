obj-m += module_init.o
module_init-objs := ./module_init.o ./tcp_server.o

BULID_DIR := /lib/modules/$(shell uname -r)/build

all: tcp_server.h
	$(MAKE) -C $(BULID_DIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(BULID_DIR) M=$(PWD) clean
	rm -rf ./zig-cache ./tcp_server.h

%.o: %.zig
	rm -f $(basename $<).h
	zig build-obj --library c -isystem ./include -femit-h=$(basename $<).h $<

tcp_server.h: tcp_server.o
	sed -i -e '/^#include <zig.h>/d; s/^ZIG_EXTERN_C/extern/; /void printk/d' "$@"