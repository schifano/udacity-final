#Xcode-Projects

## Children International Code Camp App

### What does the following bitcode error mean?

```
clang: error: linker command failed with exit code 1 (use -v to see invocation) 

ld: '/Users/schifano/CodeCamp/SwifferApp/SwifferApp/Parse.framework/Parse(PFObject.o)' does not contain bitcode. You must rebuild it with bitcode enabled (Xcode setting ENABLE_BITCODE), obtain an updated library from the vendor, or disable bitcode for this target. for architecture arm64

Enable Bitcode in Build Settings should all be set to “No” until the Framework is updated to support bitcode. This is an iOS 9 feature.
```

What does the ENABLE_BITCODE actually do, will it be a non-optional requirement in the future?
I'm not sure at what level you are looking for an answer at, so let's take a little trip. Some of this you may already know.

When you build your project, Xcode invokes clang for Objective-C targets and swift/swiftc for Swift targets. Both of these compilers compile the app to an intermediate representation (IR), one of these IRs is bitcode. From this IR, a program called LLVM takes over and creates the binaries needed for x86 32 and 64 bit modes (for the simulator) and arm6/arm7/arm7s/arm64 (for the device). Normally, all of these different binaries are lumped together in a single file called a fat binary.

The ENABLE_BITCODE option cuts out this final step. It creates a version of the app with an IR bitcode binary. This has a number of nice features, but one giant drawback: it can't run anywhere. In order to get an app with a bitcode binary to run, the bitcode needs to be recompiled (maybe assembled or transcoded… I'm not sure of the correct verb) into an x86 or ARM binary.

When a bitcode app is submitted to the App Store, Apple with take on this final step and create the finished binaries.

Right now, bitcode apps are optional, but history has shown Apple turns optional things into requirements (like 64 bit support). This usually takes a few years, so third party developers (like Parse) have time to update.

can I use the above method without any negative impact and without compromising a future appstore submission?
Yes, you can turn off ENABLE_BITCODE and everything will work just like before. Until Apple makes bitcode apps a requirement for the App Store, you will be fine.

Are there any performance impacts if I enable / disable it?
There will never be negative performance impacts for enabling it, but internal distribution of an app for testing may get more complicated.

As for positive impacts… well that's complicated.

For distribution in the App Store, Apple will create separate versions of your app for each machine architecture (arm6/arm7/arm7s/arm64) instead of one app with a fat binary. This means the app installed on iOS devices will be smaller.

In addition, when bitcode is recompiled (maybe assembled or transcoded… again, I'm not sure of the correct verb), it is optimized. LLVM is always working on creating new a better optimizations. In theory, the App Store could recreate the separate version of the app in the App Store with each new release of LLVM, so your app could be re-optimized with the latest LLVM technology.

<http://stackoverflow.com/questions/31088618/impact-of-xcode-build-options-enable-bitcode-yes-no>


Bitcode is a new feature of iOS 9

Bitcode is an intermediate representation of a compiled program. Apps you upload to iTunes Connect that contain bitcode will be compiled and linked on the App Store. Including bitcode will allow Apple to re-optimize your app binary in the future without the need to submit a new version of your app to the store.

Note: For iOS apps, bitcode is the default, but optional. If you provide bitcode, all apps and frameworks in the app bundle need to include bitcode. For watchOS apps, bitcode is required
So you should disable bitcode until all the frameworks of your app have bitcode enabled.

### What does the following remove excess frameworks error mean?

```
ld: warning: directory not found for option ‘-F/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator9.0.sdk/Developer/Library/Frameworks'
```

Go into your Projects settings and remove the excess Frameworks paths in there that you don't need.

## Background Camera

### What does bail stand for in an assertion statement?
In the example Apple code for the face detection camera, there was a bail statement. "bail" is simply a label for goto statements, just like "goto:!" This is C-based, not necessarily a required way of handling errors.

```
require( error == nil, bail );
```
```
AssertMacros.h
	#ifndef require
		#define require(assertion, exceptionLabel)  __Require(assertion, exceptionLabel)
	#endif
```

### How do you perform still and video media capture?
To manage the capture from a device such as a camera or microphone, you assemble objects to represent inputs and outputs, and use an instance of AVCaptureSession to coordinate the data flow between them. Minimally you need:

* An instance of AVCaptureDevice to represent the input device, such as a camera or microphone
* An instance of a concrete subclass of AVCaptureInput to configure the ports from the input device
* An instance of a concrete subclass of AVCaptureOutput to manage the output to a movie file or still image
* An instance of AVCaptureSession to coordinate the data flow from the input to the output
* To show the user a preview of what the camera is recording, you can use an instance of AVCaptureVideoPreviewLayer (a subclass of CALayer).

<https://developer.apple.com/library/ios/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/04_MediaCapture.html#//apple_ref/doc/uid/TP40010188-CH5-SW2>

### What is a sampleBufferDelegate?
An object conforming to the AVCaptureVideoDataOutputSampleBufferDelegate protocol that will receive sample buffers after they are captured.

This protocol defines an interface for delegates of an AVCaptureVideoDataOutput object to receive captured video sample buffers and be notified of late sample buffers that were dropped.

### What is the CIDetector class?
A CIDetector object uses image processing to search for and identify notable features (faces, rectangles, and barcodes) in a still image or video. Detected features are represented by CIFeature objects that provide more information about each feature.
<https://developer.apple.com/library/ios/documentation/CoreImage/Reference/CIDetector_Ref/>

### What is CIContext?
The CIContext class provides an evaluation context for rendering a CIImage object through Quartz 2D or OpenGL. You use CIContext objects in conjunction with other Core Image classes, such as CIFilter, CIImage, and CIColor, to take advantage of the built-in Core Image filters when processing images.

### What are some ways that I can make things wait?

* NSTimer
* Selector
* Sleep

```
Examples: 
[self performSelector:@selector(changeText:) withObject:text afterDelay:2.0];
[NSThread sleepForTimeInterval:2.0f];   
```

### What does the error 'Implicit declaration of function “…” is invalid in C99' mean?

Welp, when you try to use Swift and say self.methodName it won’t exactly work. In Objective-C, you should use [self methodName]; of course. :)

### What is EXIF?
EXIF contains a ton of information about your camera, and potentially where the picture was taken (GPS coordinates). That means, if you’re sharing images, there’s a lot of details others can glean from them.

EXIF stands for Exchangeable Image File Format. Every time you take a picture with your digital camera or phone, a file (typically a JPEG) is written to your device’s storage. In addition to all the bits dedicated to the actual picture, it records a considerable amount of supplemental metadata as well. This can include date, time, camera settings, and possible copyright information. You can also add further metadata to EXIF, such as through photo processing software.

### What is a general blue algorithm?

Blurring algorithm is used on each pixel. Gaussian blur is a commonly used algorithm.

Examine each pixel, use surrounding pixels to calculate new color value for the current pixel.
The algorithm averages the values of the surrounding pixels and inserts the value into the current pixel.
Expanding the blur radius to cover the entire image.

Note: Generally, the greater your blur radius is, the more processing power you’ll require to process the image. iOS offloads most image processing activities to the GPU to keep the main thread free.

### What classes could be used to run a background camera without the interface?
AVCaptureDevice, AVCaptureSession

### Why is the UIImage not showing up?
I went into Debug View Hierarchy and noticed that the UIImageView and UIViews for each eye and mouth were there. There was an extra UIView being added at the end. I literally thought to myself, “Where is this view being loaded?” -> “viewDidLoad” -> “ViewController.”

The tutorial implements face detection into AppDelegate, but instead I implemented it in the View Controller. This way, I was able to add a subview to the current view. Before, I was only adding views to the window which was being covered up by the new UIView being loaded by the View Controller.

In other words, the App Delegate does not have a UIView.

### Why do I need to import the CoreImage framework into the Build Phase to do face detection?
Core Image - import framework into Build Phase - why? Core Image is big, not automatically included in the SDK, probably.

### Why use DISPATCH_QUEUE_SERIAL for video frames?

DISPATCH_QUEUE_SERIAL A dispatch queue that executes
blocks serially in FIFO order. 

DISPATCH_QUEUE_CONCURRENT A dispatch queue that executes
blocks concurrently. Although they execute blocks
concurrently, you can use barrier blocks to create
synchronization points within the queue.

Makes sense, using serial dispatch means each frame that comes also goes out in order.

“a serial dispatch queue must be used to guarantee that video frames will be delivered in order”

## Miscellaneous

### What is a retain cycle and how do you fix one?

Retain Cycle - Lets say we have three objects: a grandparent, parent and child. The grandparent retains the parent, the parent retains the child and the child retains the parent. The grandparent releases the parent.

Retain Cycle is the condition When 2 objects keep a reference to each other and are retained, it creates a retain cycle since both objects try to retain each other, making it impossible to release.

Here The "Grandparent" retains the "parent" and "parent" retains the "child" where as "child" retains the "parent".. Here a retain cycle is established between parent and child. After releasing the Grandparent both the parent and child become orphaned but the retain count of parent will not be zero as it is being retained by the child and hence causes a memory management issue.

There are two possible solutions:

1) Use weak pointer to parent , i.e a child should be using weak reference to parent, which is not retained.

2) Use "close" methods to break retain cycles.

### What is ReactiveCocoa?

ReactiveCocoa is inspired by functional reactive programming. Rather than using mutable variables which are replaced and modified in-place, RAC offers “event streams,” represented by the Signal and SignalProducer types, that send values over time.

Event streams unify all of Cocoa’s common patterns for asynchrony and event handling, including:

* Delegate methods
* Callback blocks
* NSNotifications
* Control actions and responder chain events
* Futures and promises
* Key-value observing (KVO)

### What does git-blame do?

git-blame - Show what revision and author last modified each line of a file

### What is @class used for in a file?

@class is used to break a circular reference - if it’s being called somewhere else but is needed to be used somewhere else. CIDetector class, using CIDetector.

### What does the following error mean?

```
ViewController.m:40:119: Implicit conversion of Objective-C pointer type 'const NSString *' to C pointer type 'void * _Nullable' requires a bridged cast?
```

Have a look at the ARC documentation on the LLVM website. You'll have to use __bridge or one of the other keywords.

This is because Core Foundation objects (CF*Refs) are not controlled by ARC, only Obj-C objects are. So when you convert between them, you have to tell ARC about the object's ownership so it can properly clean them up. The simplest case is a __bridge cast, for which ARC will not do any extra work (it assumes you handle the object's memory yourself).

### What are the 5 app states?

State | Description
:------ | :------
Not running | The app has not been launched or was terminated, either by the user or the system.
Inactive | The app is running in the foreground but is not receiving events. (It may be executing other code though.) An app usually stays in this state only briefly as it transitions to a different state. Upon entering this state, the app should put itself into a quiescent state with the expectation of moving to the background or active state shortly.
Active | The app is running in the foreground and receiving events. This is the normal mode for foreground apps. An app in the active state has no special restrictions placed on it. It is the foreground app and should be responsive to the user.
Background | The app is executing code but is not visible onscreen. When the user quits an app, the system moves the app to the background state briefly before suspending it. At other times, the system may launch the app into the background (or wake up a suspended app) and give it time to handle specific tasks. For example, the system may wake up an app so that it can process background downloads, certain types of location events, remote notifications, and other types of events. An app in the background state should do as little work as possible. Apps that request time to process specific types of events should process those events and return control back to the system as quickly as possible.
Suspended | The app is in memory but is not executing code. The system suspends apps that are in the background and do not have any pending tasks to complete. The system may purge suspended apps at any time without waking them up to make room for other apps.

### How do I remove a subview?

Remove subview…. [subview removeFromSuperview];
You don’t need to do a release if you have ARC (automatic reference counting).

### What is the AppDelegate?

AppDelegate is root object of class, singleton object, always present at runtime.
The app delegate performs several crucial roles:

* It contains your app’s startup code.
* It responds to key changes in the state of your app. * Specifically, it responds to both temporary interruptions and to changes in the execution state of your app, such as when your app transitions from the foreground to the background.
* It responds to notifications originating from outside the app, such as remote notifications (also known as push notifications), low-memory warnings, download completion notifications, and more.
* It determines whether state preservation and restoration should occur and assists in the preservation and restoration process as needed.
* It responds to events that target the app itself and are not specific to your app’s views or view controllers.
* You can use it to store your app’s central data objects or any content that does not have an owning view controller.

### How do I list hidden files?

`ls -a`

### How do I delete a branch using git?

Deleting a remote branch:

git push origin --delete <branch>  # Git version 1.7.0 or newer
git push origin :<branch>          # Git versions older than 1.7.0

Deleting a local branch:

git branch --delete <branch>
git branch -d <branch> # Shorter version
git branch -D <branch> # Force delete un-merged branches

Deleting a local remote-tracking branch:

git branch --delete --remotes <remote>/<branch>
git branch -dr <remote>/<branch> # Shorter

git fetch <remote> --prune # Delete multiple obsolete tracking branches
git fetch <remote> -p      # Shorter

When you're dealing with deleting branches both locally and remotely, keep in mind that there are 3 different branches involved:

The local branch X.
The remote origin branch X.
The local remote-tracking branch origin/X that tracks the remote branch X.

**Note that deleting the remote branch X from the command line using a git push will also delete the local remote-tracking branch origin/X**

### Simple Objective-C method implementation.

For a simple class interface with one method, like this (.h):

```
@interface XYZPerson : NSObject
- (void)sayHello;
@end
```

The implementation might look like this (.m):

```
#import "XYZPerson.h"
 
@implementation XYZPerson
- (void)sayHello {
    NSLog(@"Hello, World!");
}
@end
```

### What is the difference between Cocoa and Cocoa Touch?
Cocoa (for OS X) and Cocoa Touch (for iOS)

### What is a HEAD in git?
HEAD is the symbolic name for the currently checked out commit.

When HEAD is detached, it points directly to a commit—instead of indirectly pointing to one through a branch. You can think of a detached HEAD as being on an unnamed branch.
When HEAD is not detached (the “normal”1 situation: you have a branch checked out), HEAD actually points to a branch’s “ref” and the branch points to the commit. HEAD is thus “attached” to a branch. When you make a new commit, the branch that HEAD points to is updated to point to the new commit. HEAD follows automatically since it just points to the branch.

(This reminds me of Linked Lists)

### How to find the main.

* UIApplicationDelegate (AppDelegate) -> UIApplication -> UIApplicationMain
* Swift -> @UIApplicationMain
* Obj-C -> main.m


