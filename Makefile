obj-m += tcp_server.o
obj-m += module_init.o

BULID_DIR := /lib/modules/$(shell uname -r)/build
KERNEL_INCLUDES := $(BULID_DIR)/include

all: tcp_server.h
	$(MAKE) -C $(BULID_DIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(BULID_DIR) M=$(PWD) clean
	rm -rf ./zig-cache ./tcp_server.h

%.o: %.zig
	rm -f $(basename $<).h
	cp -r $(KERNEL_INCLUDES)/linux/* ./include/.
	zig build-obj --library c -isystem ./include -femit-h=$(basename $<).h $<

tcp_server.h: tcp_server.o
	sed -ine '/^#include <zig.h>/d; s/^ZIG_EXTERN_C/extern/; /void printk/d' "$@"

#zig-y += tcp_server.o module.o