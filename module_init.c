#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>

#include "module_main.h"

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Seiki Makino");
MODULE_DESCRIPTION("A simple example Linux module.");
MODULE_VERSION("0.01");

static int __init lkm_example_init(void) {
    printk(KERN_INFO "Calling zig.\n");
    init_hellokernel();

    return 0;
}

static void __exit lkm_example_exit(void) {
    exit_hellokernel();
    printk(KERN_INFO "Exited zig.\n");
}

module_init(lkm_example_init);
module_exit(lkm_example_exit);