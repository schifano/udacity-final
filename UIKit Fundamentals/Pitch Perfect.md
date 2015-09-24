# Pitch Perfect

## Lessons Learned

### Xcode Manual Preview of App

View how your app looks without having to always run your app.

* Click on storyboard, then use the Assistant Editor
* On the ribbon, click on “Manual”
* Go to Preview
* (+) sign allows you to add devices you can see, try iPhone and iPad

### Size Classes in Interface Builder (IB)

* How to use Any Any
	* Stay in Any Any to make your app compatible across devices. For this project, I originally had it in Compact Regular because it wasn’t specified in the Udacity course and I wanted it to be for the iPhone. However, that did not make it compatible across all other device sizes.
* Simulated Metrics
	* Click on a view controller (or just navigation controller).
	* Set the Size to whatever device you are interested in.
	* The rest of the views will display the device size of their parent view when Size is “Inferred” (like inheriting).
* Move app from Compact Regular (or w/e other size) to Any Any size configuration
	* Show Document Outline - grayed out items listed mean they exist but are not currently “installed” in your current view. 
	* Click on each faded item and Show Utilities.
	* Go to Size Inspector and scroll to the bottom
	* (+) and (x), mark the unchecked check box to “install”
click x to remove the wC hR.

### Simulator does not have Voice Over!

In making Pitch Perfect an accessible app, I discovered Simulator does not have Voice Over. Voice Over is only available for testing on a real device.

Use Accessibility Inspector instead. <https://developer.apple.com/library/ios/technotes/TestingAccessibilityOfiOSApps/TestAccessibilityiniOSSimulatorwithAccessibilityInspector/TestAccessibilityiniOSSimulatorwithAccessibilityInspector.html>

### Accessibility

Notes I picked up from a WWDC 2014 Accessibility on iOS talk. <https://developer.apple.com/videos/wwdc/2014/>

* Visual Accommodations API  - turn on accessibility to try, check if options are on, then accommodate
* Semantic Accessibility - audit with Voice Over
	* Can Voice Over speak everything?
	* Can Voice Over do everything?
* Code
	* isAccessibilityElement, YES to make a view visible to accessible tech
	* accessibilityLabel - describes a view
* Types of Accessibility Options on device
	* Zoom. Magnifies the entire device screen.
	* White on Black. Inverts the colors on the display.
	* Mono Audio. Combines the sound of the left and right channels into a mono signal played on both sides.
	* Speak Auto-text. Speaks the text corrections and suggestions iPhone makes while users type.
	* Voice Control. Allows users to make phone calls and control iPod playback using voice commands.

### Swift Docs - Double vs Triple Slashes

Triple slash comments vs two slash comments - triple for important things like classes, two for developers

### Swift Documentation

* // MARK:
* // TODO:
* // FIXME:
* :param:
* :returns:

### Nibs vs. Xibs

A Xib is more or less an XML document, it is the uncompiled read/write version of a nib. Once you compile a xib it becomes a nib.

### Update Constraints vs. Update Frames

* Update Frames - update the storyboard to fit current constraints.
* Update Constraints - update the constraints to match what is presented in storyboard.

### What comes to mind with the word delegate?

* Delegate work or responsibility in an office
* UN Delegate
* Someone that acts on your behalf in specific ways
* Not my problem

### What is the example AVAudio code doing?

```
import AVFoundation
//Declared Globally
var audioRecorder:AVAudioRecorder!

//Inside func recordAudio(sender: UIButton)
let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String


let currentDateTime = NSDate()
let formatter = NSDateFormatter()
formatter.dateFormat = "ddMMyyyy-HHmmss"
let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
let pathArray = [dirPath, recordingName]
let filePath = NSURL.fileURLWithPathComponents(pathArray)
println(filePath)

var session = AVAudioSession.sharedInstance()
session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)

audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
audioRecorder.meteringEnabled = true
audioRecorder.record()
```

* Line 1: The AVFoundation framework is made accessible to the code.
* Line 3: A variable is created for audioRecorder
* Line 5: The file will be saved in the documents directory
* Line 6: The current date is retrieved.
* Line 7: The object that will format the date is created.
* Line 8: The date is formatted to ddMMyyyy-HHmmss
* Line 9: The .wav file is named with the date of the recording
* Line 10: The location of the file and the file name are placed in an array
* Line 11: The file path is create as a constant with the contents of the array
* Line 12: The file path is displayed on the screen
* Line 13: A recording session is created
* Line 14: This session is made capable of playing and recording media
* Line 15: The file path is assigned to the file that will be created in this recording session
* Line 16: Audio metering is enabled for the file that will be created
* Line 17: The app begins the recording."

### var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")

"The documentation suggested that we get the directory where the application executable is located using mainBundle.

And then with pathForResource we get the file path for the file named 'movie_quote.mp3'."

### UINavigationController Final Exam Question

Short Answer (1-2 paragraphs)
Describe the UINavigationController and its relationship to hierarchy.

Describe the data structure used for the UINavigationController. Draw a diagram of the data structure and label the **root** and **current** view controller. List and discuss two important methods for adding and removing view controllers from this data structure.

### Three things learned about UINavigationController

1. The navigation stack has an underlying array of view controllers as the data structure. In the navigation stack, the first view controller in the stack is the root view controller and the last is the current view controller. (LIFO)

2. The navigation bar is always present and is managed by the navigation controller. The toolbar at the bottom is optional.

3. There are three navigation bar items: left, middle, right. All three can be customized. The left and middle bar items have defaults but the right default does not display any item.

### Storyboard updates for Pitch Perfect buttons.

* Notes
	* Create a new View to contain subviews which are the UIButtons.
	* Use Document Outline to dump all the buttons into it. Place them in the positions you would like.
	* It makes sense to keep the stop button close / near the bottom of the phone. NOTE - make the other stop button (from the previous screen)line up.
	* Button is also horizontally aligned. Center x alignment.
	* Button has constraint to the bottom edge of the screen.
	* The view is aligned with vertical spacing to the button. >= 50, meaning that the button may adjust depending on the size of the screen (relative to the view)
* Snail
	* Equal Heights constraint
	* Equal Width constraints
	* Aspect ratio (point to itself)
	* Bound to top and left
* Chipmunk
	* Drag to the Snail for the equal, because the snail will be the right proportion, so will the others
	* Equal Heights constraint
	* Equal Width constraints
	* Need to have Center Y alignment, because all other constraints were ambiguous, distance wise, be careful of any additional padding, it might misalign the button
	* Vertical space, >= 20, <= 50, so that it can adjust - likely causing warning because of ambiguity
* Reverb
	* Drag to the Snail for the equal, same as chipmunk
	* Equal Heights constraint
	* Equal Width constraints

### View Lifecycle

<http://stackoverflow.com/questions/5562938/looking-to-understand-the-ios-uiviewcontroller-lifecycle>

* **viewDidLoad** - Called when you create the class and load from xib. Great for initial setup and one-time-only work.
* **viewWillAppear** - Called right before your view appears, good for hiding/showing fields or any operations that you want to happen every time before the view is visible. Because you might be going back and forth between views, this will be called every time your view is about to appear on the screen.
* **viewDidAppear** - Called after the view appears - great place to start an animations or the loading of external data from an API.
* **viewWill/DidDisappear** - Same idea as WillAppear.
* **viewDidUnload/ViewDidDispose** - In Objective C, this is where you do your clean-up and release of stuff, but this is handled automatically so not much you really need to do here.

### Actions in Storyboard

Action - In this case the View sends a message to our ViewController. Much like when we write an action inside our ViewController to do something when the microphone button is pressed.

### Force unwrap an optional

Once you’re sure that the optional does contain a value, you can access its underlying value by adding an exclamation mark (!) to the end of the optional’s name. The exclamation mark effectively says, “I know that this optional definitely has a value; please use it.” This is known as forced unwrapping of the optional’s value.

### Segue three ways.

1. Programmatically
2. Code + storyboard (segue)
	Create segue from VC to next view (push, modal, custom)
	create segue ID
3. "No Code" (prepareForSegue lol)


### One Commit per Logical Change Solution

Each commit should have one clear, logical purpose, and you should never do too much work without committing.

Example Scenarios:

1. You commit all the changes required to add a new feature, which you’ve been working on for a week. You haven’t committed since you started working on it.
	* This commit seems too big. It's easier to understand what each commit does if each only does one thing and is fairly small. Going a week without committing is not the best idea.
2. You found three typos in your README. You fix and commit the first.
	* This commit seems too small. It would be better to fix all three typos, then commit. That way, your history won't get too cluttered with typo fixes. Plus, you don’t need to worry about introducing bugs to a README, so bundling changes together is more likely to be a good idea.
3. You commit all the changes required to add a new feature, which you’ve been working on for an hour.
	* This is probably a good size for a commit. All the work is on a single feature, so the commit will have a clear logical purpose. After an hour, the diff will probably have a fair amount of content in it, but not too much to understand.
	* On the other hand, sometimes after working for an hour you’ll have run into more than one natural committing point, in which case you would want to break the feature up into smaller commits. Because of this, “too big” could also be a reasonable answer here.
4. You fix two small bugs in different functions and commit them both at once.
	* This commit is probably too big. It would have been better to commit after the first bug fix, since the two bug fixes aren't related to each other.
