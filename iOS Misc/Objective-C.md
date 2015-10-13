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

### Why isn’t the captureOutput method being called?
This method had run once another time but then stopped. It seemed to be working intermittently.

The code originally had:

```
ViewController.m

- (void)setupAVCapture {
    NSError *error = nil;
    AVCaptureSession *session  = [[AVCaptureSession alloc] init];
```

Basically, the session scope was limited to the method setupAVCapture. The session would be deallocated by the completion of this method. I moved the session declaration to ViewController.h and instead instantiated the variable in setupAVCapture.

```
ViewController.h
@interface ViewController : UIViewController <UIGestureRecognizerDelegate, AVCaptureVideoDataOutputSampleBufferDelegate> {
    
    AVCaptureSession *session;
    AVCaptureVideoDataOutput *videoDataOutput;
    AVCaptureStillImageOutput *stillImageOutput;
    dispatch_queue_t videoDataOutputQueue;
    BOOL detectFaces;
    CIDetector *faceDetector;   
}

ViewController.m
- (void)setupAVCapture {
    NSError *error = nil;
    
    session = [[AVCaptureSession alloc] init];

```
Why would the delegate method captureOutput run once or intermittently before? It could be because the call for the session was being made asynchronously, and the delegate method would run at least once just before the session would end.

### Expected Identifier error
Maybe you have an extra bracket somewhere (or missing one).

### Why do some import statements have Name/Name.h and others just have Name.h?

```
#import <ImageIO/ImageIO.h>
#import <AssertMacros.h>
```

Chances are there is a framework that needs to be manually added to your build phase because it’s not automatically included in the SDK.
