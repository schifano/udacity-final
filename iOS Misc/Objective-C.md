# Objective-C Adventures

As it turns out, extensive knowledge of Swift and a solid understanding of iOS really makes learning Objective-C pretty easy.

```
@interface classname : superclass

```

## Bugs and Lessons Learned

### compilation warning: no rule to process file for architecture i386

Click on your project, and check that this file is not present in the tab Build Phases. Normally no header files should stay here. Clean and build it again, it should work!

BUT WHY NOT THERE?

Because this is the list of source files that will be compiled, and normally you have already included <file>.h inside your <file>.m –

thnx SO