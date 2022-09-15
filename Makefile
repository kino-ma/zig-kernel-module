obj-m += module_init.o

BULID_DIR := /lib/modules/$(shell uname -r)/build
KERNEL_INCLUDES := $(BULID_DIR)/include

all:
	$(MAKE) -C $(BULID_DIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(BULID_DIR) M=$(PWD) clean
	rm -rf ./zig-cache

%.o: %.zig
	zig build-obj --library c -isystem ${KERNEL_INCLUDES} $<

%.h: %.o