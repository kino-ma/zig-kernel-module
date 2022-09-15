const c = @cImport({
    @cInclude("linux/kernel.h");
    @cInclude("linux/module.h");
    @cInclude("linux/printk.h");
});

export fn init_hellokernel() c_int {
    const c_str: [*c]const u8 = "Hello kernel!\n";
    c.printk(c_str);
    return 0;
}

export fn exit_hellokernel() void {
    const c_str: [*c]const u8 = "Goodbye kernel!\n";
    c.printk(c_str);
}
