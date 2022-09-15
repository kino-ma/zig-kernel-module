obj-m += my_sample_module.o
my_sample_module-objs := ./module_init.o ./module_main.o

BULID_DIR := /lib/modules/$(shell uname -r)/build
KERNEL_INCLUDES := $(BULID_DIR)/include

all: module_main.h
	$(MAKE) -C $(BULID_DIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(BULID_DIR) M=$(PWD) clean
	rm -rf ./zig-cache ./module_main.h

%.o: %.zig
	rm -f $(basename $<).h
	zig build-obj --library c -isystem ./include -isystem $(KERNEL_INCLUDES) -femit-h=$(basename $<).h $<

module_main.h: module_main.o
	sed -i -e '/^#include <zig.h>/d; s/^ZIG_EXTERN_C/extern/; /void printk/d' "$@"