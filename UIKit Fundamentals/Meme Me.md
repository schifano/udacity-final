# Meme Me


#NSNotifications

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

Makes sense. I fixed this by adjusting the tableView.rowHeight in viewWillAppear. Note - there is now tableView.rowWidth. That's a whole 'nother thing.

