# Meme Me


## NSNotifications

NSNotifications provide a way to announce information throughout a program across classes, like a keyboard appearing or disappearing.

Objects have to subscribe to or observe notifications.
Subscribe and unsubscribe from notifications.

The NSNotification class provides a way to announce information throughout a program, across classes. 

Each notification has three properties:

1. a name
2. an optional userInfo dictionary
3. an optional object

Term | Description
---- | ----
**addObserver:** | An object that wants to receive an event notification has to sign up to hear it.
**removeObserver:** | An object that wants to unsubscribe from event notifications.
**NSNotificationCenter** | The class that acts as the dispatch center for NSNotifications. Communication tool internal to your app.

Every iOS program has one default NotificationCenter, NSNotificationCenter.defaultCenter()

* Stock notifications (like notification keys, but stock)
	* UIKeyboardWillShowNotification
		* One can also create custom notifications using **postNotificationName:**
		
### NSNotificationCenter

It provides a way for one instance of a class/struct to notify one or more other class/struct instances about something. The goal in doing this is to enable those 1+ other class or struct instances to take appropriate action based the communication they receive.

radio tower - broadcast communications

instance-to-instance communication at run-time

NSNotificationCenter is particularly useful when there are multiple class or struct instances that need to take action based on something that happens elsewhere in your application. 

### NSNotification Objects

NSNotification objects encapsulate information so that it can be broadcast to other objects by an NSNotificationCenter object

An NSNotification object (referred to as a notification) contains:

* name - The name is a tag identifying the notification
* object - The object is any object that the poster of the notification wants to send to observers of that notification (typically, it is the object that posted the notification)
* optional dictionary - The dictionary stores other related objects, if any.

NSNotification objects are immutable objects.

### Resources

* Fundamentals of NSNotificationCenter in Swift  
<http://www.andrewcbancroft.com/2014/10/08/fundamentals-of-nsnotificationcenter-in-swift/>
* NSNotification Class Reference  
<https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSNotification_Class/index.html#//apple_ref/occ/instp/NSNotification/userInfo>
* NSNotification & NSNotification​Center <http://nshipster.com/nsnotification-and-nsnotificationcenter/>


## Structs vs. Classes

### Value Types vs. Reference Types 

If you've coded in Objective-C you've worked with reference types almost the entire time, NSArray, NSDictionary, etc. are all reference types. Objective-C only has very few value types, e.g. NSInteger and CGFloat.

### Value Types

Value types behave different upon assignment. When a value type is assigned to a variable the variable always stores the value itself, not a reference to a value. This means whenever a value is assigned to a new variable, that variable gets its own copy of the value. A value can always only have one owner. In Swift, arrays are implemented as value types (they are structs!). So let's take a look at the same example in Swift:

### Reference Types


# Bugs and Lessons Learned

### Collection view items are too big in landscape mode.

The collection view items were sized proportionally only by width so that items looked fine in portrait mode. However, that would create very large collection items in landscape mode. I checked for portrait or landscape to determine whether to use width or height as a factor for finding the dimensions of each item.

### ‘UITableViewCell’ does not have a member named 'topTextLabel'

The code was downcasting to UITableViewCell when I needed to downcast to my custom view cell, MemeTableViewCell, which did have a member “topTextLabel." Remember! Using as! means forced downcasting (Swift is fun).

### Calling reloadData() on tableView causes app to crash.

Several things likely happened but the code changed enough that eventually calling self.tableView.reloadData() in the viewWillAppear worked without crashing.

The first workaround via a SO suggestion was to create a helper method that refreshed the data on the main thread. This seemed viable since the main thread can be good for updating the UI for the user. dispatch_async means it would be immediately added and executed whenever the call was next in the main thread queue.

```
 /**
        Helper method for refreshing the data on the main thread displayed in the table view.
    */
    func refreshUI() {
        dispatch_async(dispatch_get_main_queue(),{
            self.tableView.reloadData()
        });
    }
 ```
 
The second thing I tried also worked, but by then there was a bit of Storyboard that changed which may have contributed. I was able to call self.tableView.reloadData() directly in the viewWillAppear method, so long as it was after the class called the model in order to receive the memes array / object. This prevent the error of the compiler finding "nil" when trying to return memes.count.

### Dynamic prototype cells will not update row height when running.

Although the row height was set to be greater (around 150) in Storyboard, running the app would display table row heights to be smaller. Per SO <http://stackoverflow.com/questions/8615862/custom-cell-row-height-setting-in-storyboard-is-not-responding>:

"On dynamic cells, rowHeight set on the UITableView always overrides the individual cells' rowHeight.

But on static cells, rowHeight set on individual cells can override UITableView’s."

Makes sense. I fixed this by adjusting the tableView.rowHeight in viewWillAppear. Note - there is no tableView.rowWidth. That's a whole 'nother thing.

### Text field constraints are misaligned when screen shot is taken.


### How do I get the height of a navbar?

self.navigationController.navigationBar.frame.size.height

### Dictionary of text attributes will do what?

Override all Storyboard defaults.

### Why do some selectors have a colon and others do not?

selector: “keyboardWillShow:"

The colon is needed after the method's name if and only if the method takes an argument.

In certain cases, the number of colons can determine arguments. For example, if you pass in an action method with one colon, it'll send the sender as the first argument. If you pass in a selector with two colons, you'll get the event as well. No colon means, obviously, no arguments.

<http://stackoverflow.com/questions/7310392/use-colon-or-not-with-selectors>

### Why is NSStrokeWidth not allowing text to be filled?

NSStrokeWidthAttributeName: "-3.0"

Use negative value to allow stroke AND fill. Positive values will not fill the text.

### Tried to insert an image into an alert view. Bad idea.

```
2015-08-13 13:01:42.014 MemeMe[2788:209152] Unable to simultaneously satisfy constraints.
	Probably at least one of the constraints in the following list is one you don't want. Try this: (1) look at each constraint and try to figure out which you don't expect; (2) find the code that added the unwanted constraint or constraints and fix it. (Note: If you're seeing NSAutoresizingMaskLayoutConstraints that you don't understand, refer to the documentation for the UIView property translatesAutoresizingMaskIntoConstraints) 
(
    "<NSLayoutConstraint:0x7fedc5947650 H:|-(399)-[UIView:0x7fedc5918a40]   (Names: '|':_UIAlertControllerActionView:0x7fedc591bd70 )>",
    "<NSLayoutConstraint:0x7fedc5948f60 UIView:0x7fedc5918a40.trailing == _UIAlertControllerActionView:0x7fedc591bd70.trailing - 399>",
    "<NSLayoutConstraint:0x7fedc588f530 _UIAlertControllerActionView:0x7fedc591bd70.width == UIView:0x7fedc5871ad0.width>",
    "<NSLayoutConstraint:0x7fedc588f120 UIView:0x7fedc5871ad0.width == _UIAlertControllerCollectionViewCell:0x7fedc5871690.width>",
    "<NSLayoutConstraint:0x7fedc589d070 'UIView-Encapsulated-Layout-Width' H:[_UIAlertControllerCollectionViewCell:0x7fedc5871690(375)]>"
)

Will attempt to recover by breaking constraint 
<NSLayoutConstraint:0x7fedc5948f60 UIView:0x7fedc5918a40.trailing == _UIAlertControllerActionView:0x7fedc591bd70.trailing - 399>

Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
2015-08-13 13:01:42.020 MemeMe[2788:209152] Unable to simultaneously satisfy constraints.
	Probably at least one of the constraints in the following list is one you don't want. Try this: (1) look at each constraint and try to figure out which you don't expect; (2) find the code that added the unwanted constraint or constraints and fix it. (Note: If you're seeing NSAutoresizingMaskLayoutConstraints that you don't understand, refer to the documentation for the UIView property translatesAutoresizingMaskIntoConstraints) 
(
    "<NSLayoutConstraint:0x7fedc5947650 H:|-(399)-[UIView:0x7fedc5918a40]   (Names: '|':_UIAlertControllerActionView:0x7fedc591bd70 )>",
    "<NSLayoutConstraint:0x7fedc5948f60 UIView:0x7fedc5918a40.trailing == _UIAlertControllerActionView:0x7fedc591bd70.trailing - 399>",
    "<NSLayoutConstraint:0x7fedc588f530 _UIAlertControllerActionView:0x7fedc591bd70.width == UIView:0x7fedc5871ad0.width>",
    "<NSLayoutConstraint:0x7fedc588f120 UIView:0x7fedc5871ad0.width == _UIAlertControllerCollectionViewCell:0x7fedc5871690.width>",
    "<NSAutoresizingMaskLayoutConstraint:0x7fedc58959a0 h=--& v=--& H:[_UIAlertControllerCollectionViewCell:0x7fedc5871690(375)]>"
)

Will attempt to recover by breaking constraint 
<NSLayoutConstraint:0x7fedc5948f60 UIView:0x7fedc5918a40.trailing == _UIAlertControllerActionView:0x7fedc591bd70.trailing - 399>

Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
```

### Can I center text using defaultTextAttributes?

By default, this property returns a dictionary of text attributes with default values.
textAlignment itself is also a property. May not be able to access a textAlignment property through an attribute of a property.


### Why call self. on this activityController handler?

```
activityController.completionWithItemsHandler = { activity, success, items, error in
            println("Activity: \(activity) Success: \(success) Items: \(items) Error: \(error)")
            // Save the meme
            self.save()
            // Dismiss View Controller
            self.dismissViewControllerAnimated(true, completion: nil)
}
```
Block/Closure - Call self on dismissViewControllerAnimated because scope is limited to block and needs to know which controller is being called...the one that was passed through the share() function.

### What does the Swift language compile to?

Swift, like Objective-C, is compiled to machine code (llvm bit-code) that runs on the Objective-C runtime.

### Why use a struct for my Meme object?

According to Apple's documentation, structs should be preferred over classes whenever possible. Since Meme instances are only used to store simple values and don't require the functionality of classes, using a struct would better serve its purpose.

Another advantage of using a struct is that they come with a built-in initializer. So as long as the parameter names are the same as the member variables, the custom initializer is not needed and can be removed.

### Steps to add a CollectionViewController alongside the TableViewController

* Drag in a Navigation Controller.
* Delete the root view controller that comes with the Navigation Controller.
* Drag in a CollectionViewController.
* Set the root view controller of the Navigation Controller to be the CollectionViewController you just added.
* Add the Collection View Controller to the tab bar. To do this, control-click on the Tab Bar Controller. Under Triggered Segues drag from viewControllers to the Navigation Controller you just added.
* Open the identity inspector and set the class of the CollectionViewController to “VillainCollectionViewController”. (For MemeMe, this will be the “SentMemesCollectionViewController”).
* Click on the Collection View Cell in your Collection View.
* Open the identity inspector and set the cell class and reuseIdentifier to be “VillainCollectionViewCell”. (For MemeMe, this will be the custom cell class you created earlier.)
* For practice, drag a UIImageView into the Collection View Cell.
* Connect the imageView outlet of the VillainCollectionViewCell to the UIImageView you just added.
* Run the project!

### Why was UICollectionView not displaying any data?

Needed to recall reloadData() to update the current view with the newly created meme data.

### Why is dequeueReusableCellWithIdentifier efficient?

* If a cell object is reusable—the typical case—you assign it a reuse identifier (an arbitrary string) in the storyboard.
* At runtime, the table view stores cell objects in an internal queue. When the table view asks the data source to configure a cell object for display, the data source can access the queued object by sending a dequeueReusableCellWithIdentifier: message to the table view, passing in a reuse identifier.
* The data source sets the content of the cell and any special properties before returning it. This reuse of cell objects is a performance enhancement because it eliminates the overhead of cell creation.

<https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/TableView_iPhone/TableViewCells/TableViewCells.html>

### What does the as! Operator do?

```
var memeEditorController = navigationController.topViewController as! MemeViewController
```

Prior to Swift 1.2, the as operator could be used to carry out two different kinds of conversion, depending on the type of expression being converted and the type it was being converted to:

Guaranteed conversion of a value of one type to another, whose success can be verified by the Swift compiler. For example, upcasting (i.e., converting from a class to one of its superclasses) or specifying the type of a literal expression, (e.g., 1 as Float).

Forced conversion of one value to another, whose safety cannot be guaranteed by the Swift compiler and which may cause a runtime trap. For example downcasting, converting from a class to one of its subclasses.

<https://developer.apple.com/swift/blog/?id=23>

### What is Extended Binary Coded Decimal Interchange Code (EBCDIC)?

EBCDIC is an 8-bit character encoding used mainly on IBM mainframe and IBM midrange computer operating systems.

EBCDIC descended from the code used with punched cards and the corresponding six bit binary-coded decimal code used with most of IBM's computer peripherals of the late 1950s and early 1960s.

<https://en.wikipedia.org/wiki/EBCDIC>

### What is Multipurpose Internet Mail Extensions (MIME)?

MIME is an Internet standard that extends the format of email to support:

* Text in character sets other than ASCII
* Non-text attachments: audio, video, images, application programs etc.
* Message bodies with multiple parts
* Header information in non-ASCII character sets
* Virtually all human-written Internet email and a fairly large proportion of automated email is transmitted via SMTP in MIME format.

<https://en.wikipedia.org/wiki/MIME>

### What are the ASCII values for unaccented English letters?

Unaccented English letters, and we had a code for them called ASCII which was able to represent every character using a number between 32 and 127. Space was 32, the letter "A" was 65, etc. This could conveniently be stored in 7 bits.

### What does ANSI stand for?

American National Standards Institute (ANSI)

### What is a Code Point?

Every platonic letter in every alphabet is assigned a magic number by the Unicode consortium which is written like this: U+0639.  This magic number is called a code point. The U+ means "Unicode" and the numbers are hexadecimal. U+0639 is the Arabic letter Ain. The English letter A would be U+0041.

### Why does the Content-Type have to be the very first meta tag on the page?

```
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
```

That meta tag really has to be the very first thing in the <head> section because as soon as the web browser sees this tag it's going to stop parsing the page and start over after reinterpreting the whole page using the encoding you specified.

### What are schemes?

It's basically a collection of the targets to build / test and configuration settings.

### What is flowLayout.minimumInteritemSpacing?

The minimum spacing to use between items in the same row.

### What is flowLayout.itemSize?

The default size to use for cells. (CGSize = width/height)

### What does the clipsToBounds property do?

A Boolean value that determines whether subviews are confined to the bounds of the view.

* Setting this value to YES causes subviews to be clipped to the bounds of the receiver.
* If set to NO, subviews whose frames extend beyond the visible bounds of the receiver are not clipped. The default value is NO.

### What does UIViewContentModeScaleAspectFill do?

The option to scale the content to fill the size of the view. Some portion of the content may be clipped to fill the view’s bounds.

Clipped, I guess meaning like cropped.

### Meme images in the meme image view not filling the screen or cropping. ?

The meme images in the meme image view for the table view cell were not filling the screen or cropping. AspectFit would keep the aspect but would have transparent space where the image did not fit. AspectFill was best because it filled the entire view. However, it was still spilling out of the view, although there was a translucent outline of the image view showing where it should crop. I just set UIImageView Drawing property to Clip Subviews and it worked.

### Selecting a row in the Table View will not display the detail unless I select another row immediately after. ?

I did not notice immediately, but instead of calling didSelectRowAtIndexPath, I was calling didDeselectRowAtIndexPath. I did not immediately notice since I was focusing on the actual code inside the method, not the method declaration. ;(

### The image that was displayed on the table view cell was not scaled appropriately. ?

```
cell.imageView?.image = meme.originalImage should be cell.memeImageView
```

The image that was displayed on the table view cell was not scaled appropriately even though it said scale to fill (?) in the cell storyboard settings. That is because I was not calling the image view (memeImageView) which was in the custom cell MemeTableViewCell. EASY FIXED.

### Implement an unwind segue for the Cancel button.

Why? Because it’s pretty simple. I removed the outlets from the Cancel button, and the method I was using for dismissing the view controller originally (cancelImagePicker) now passes a segue. By dragging an outlet from the Cancel button to the Exit on Storyboard, the unwind segue would pop the view it’s exiting in order to display the last view to have shown (so say, the table view).

The outlet is empty, and needs to be for the Unwind / Exit Segue. In this case, the method is also empty because no data is being passed for the Cancel, but it would be able to pass data.

This method is also located in the TableViewController and CollectionViewController so that depending on where the user last was before opening the editor, they can cancel and return to either view.

```
    @IBAction func cancelImagePicker(segue: UIStoryboardSegue) {
    }
```

### Trying to pass an image to a DetailViewController. Fatal error: unexpectedly found nil while unwrapping an Optional values

Trying to pass an image to a DetailViewController. Fatal error: unexpectedly found nil while unwrapping an Optional values

When the memes are displayed in the collectionView, you have to assign the detailController you are trying to pass that data to. In this case, it was SentMemesDetailViewController. I had to instantiate a single Meme object (not the array) in the SentMemesDetailViewController so that I could assign the currently selected meme (self.memes[indexPath.row]) from the collection view.

After I assigned that single meme object, I was able to get the properties / image from it in the SentMemesDetailViewController! 

```
override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let detailController = self.storyboard?.instantiateViewControllerWithIdentifier("SentMemesDetailViewController") as! SentMemesDetailViewController
        detailController.meme = self.memes[indexPath.row]
        self.navigationController?.pushViewController(detailController, animated: true)
}

class SentMemesDetailViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!

    var meme: Meme!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.detailImageView.image = self.meme.memedImage
    }
}
```

### Why was there an explosion of constraint errors with each rotation attempt?

There were constraints with equal priority set on each top and bottom text field, and also a vertical constraint between them. The errors hinted that UITextField was attempting to be broken to solve the issue, which caused further errors. I set the priority to the middle vertical constraint to be lower than the others, so that IB knew to first set the text field constraints   on the view before the spacing between them.

### How do I set the MemeEditor to run initially and once at launch time?

When the final Udacity MemeMe app example launches it immediately displays the Meme Editor the first time. My version of MemeMe displayed the table view when it launched. In order to get the Meme Editor to show up one time, I tried a number of things:

#### Did not work:
Tried to move entry point to app to the Meme Editor. This cannot work alone, since there needs to be a segue to the tab bar controller.

Create a segue from the Meme Editor view controller to the tab bar controller. The problem here is, upon what action from the user should this be triggered?

The other problem is, if the segue is to the Meme Editor, it might show that editor without the navigation controller which is essential.

#### Did work:
Instead of switching the entry point, I tried leaving the entry point on the tab view controller. If it was the first time the table view was about to show (so the app is launching) it would immediately segue without animation to the navigation controller attached to the Meme Editor VC. That means I had to create code to segue to the navigation controller instead of the meme editor. In viewDidLoad for the tableView, if it was the first run, it would call a segue method I created.

```
    override func viewDidLoad() {
        super.viewDidLoad()
        if firstRun == true {
            firstRun = false
            segue()
        }
    }

func segue() {
        var navigationController = self.storyboard?.instantiateViewControllerWithIdentifier("MemeNavigationViewController") as! UINavigationController
        // Present the view controller
        self.presentViewController(navigationController, animated: false, completion: nil)
    }
```

**NOTE: This ended up NOT being the functionality Udacity expected. Displaying the table of memes first was preferred.
**

### Why won’t the tab bar hide when I change views?

I decided to hide the tab bar on both the table and collection views whenever "viewWillDisappear" was called. I had to show the tab bar for both "viewWillAppear" and "viewDidAppear." If I called showTabBar for only viewWillAppear, switching from collection view to table view, for example, would not enable the tab bar for the table view. If I called showTabBar for only viewDidAppear, the table view will start to appear, and a second later the tab bar will show. Calling show for both these  view methods allows normal behavior.

### The upside down orientation would not work even when Storyboard had checked Device Orientation to All.

The Storyboard setting for Device Orientation does not guarantee that orientation will be enabled. This just means that your app *may* support the orientation. You have to programmatically set the orientation to All.

The MemeMe app was intended for iPhone only. iPhones by default do not support ALL orientations, just all exclusing upside-down. The reason for this is that it would be very inconvenient if the user received a phone call while the device was oriented upside down. iPads, however, default to supporting all orientations.

In order to override device orientation for iPhone to be All, the root view needed to support it. In this case, the TabBarController is the root view, so I subclassed MemeTabBarController to override the following methods:

```
override func shouldAutorotate() -> Bool {
    return true
}

override func supportedInterfaceOrientations() -> Int {
    return Int(UIInterfaceOrientationMask.All.rawValue)
}
```

As a result, all subsequent views would then inherit this functionality.

The reason I wanted to support upside down orientation was because the navigation was breaking when it rotated to upside down. Also, it just seemed feasible that a person might be trying to take a photo upside down. Although, this goes against standards so I would need to remove that support. However, it was a great learning experience!

Apple Discussion

When the user changes the device orientation, the system calls this method on the root view controller or the topmost presented view controller that fills the window. If the view controller supports the new orientation, the window and view controller are rotated to the new orientation. This method is only called if the view controller's shouldAutorotate method returns YES.

Override this method to report all of the orientations that the view controller supports. The default values for a view controller's supported interface orientations is set to UIInterfaceOrientationMaskAll for the iPad idiom and UIInterfaceOrientationMaskAllButUpsideDown for the iPhone idiom.