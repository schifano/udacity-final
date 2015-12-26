# Networking and Web Services

## Getting data with HTTP

HTTP - hypertext transfer protocol

Protocol

* A way of communicating
* Standard operating procedure
* The rules for communication

Term | Description | 
:------------ | :-------------
NSURLSession class / object | API for downloading content via HTTP. Asynchronous, returns data to a completion handler block or custom delegate methods.
NSURLRequest object | Represents a URL load request. Encapsulates two basic data elements of a load request: 1) the URL to load 2) the policy to use when consulting the URL content cache made available by the implementation
NSURLSessionDataTask class | A data task returns data directly to the app (in memory) as one or more NSData objects
NSURLComponents class | Designed to parse URLs based on RFC 3986 and to construct URLs from their constituent parts. Create a URL components object: 1) from an NSString object that contains a URL 2) from an NSURL object 3) from scratch by using the default initializer


There are three types of configuration objects, there are similarly **three types of session**:

* *default sessions* - behave much like NSURLConnection
* *ephemeral sessions* - do not cache anything to disk
* *download sessions* - store the results in a file and continue transferring data even when your app is suspended, exits, or crashes.

Within those sessions, you can schedule three types of tasks: 

* *data tasks* - for retrieving data to memory
* *download tasks* - for downloading a file to disk
* *upload tasks* - for uploading a file from disk and receiving the response as data in memory

### HTTP GET Method

The HTTP GET method can be used to request data from a server using a Uniform Resource Locator (URL). For example, if you wanted to get the data from this course's overview page, you would use the following request:

GET http://www.udacity.com/course/ud421

This request will return all the data associated with the course's overview page--including any images, scripts, and other data required to build the page.


This review will go over the commented sections in the ViewController.swift file:

```
/* 1 - Define constants */
let BASE_URL = "https://api.flickr.com/services/rest/"
let METHOD_NAME = "flickr.galleries.getPhotos"
let API_KEY = "ENTER_YOUR_API_KEY_HERE"
let GALLERY_ID = "5704-72157622566655097"
let EXTRAS = "url_m"
let DATA_FORMAT = "json"
let NO_JSON_CALLBACK = "1"
Here, we define some constants used in the app. Each of these constants are used to construct the URL of the HTTP GET request.

/* 2 - API method arguments */
let methodArguments = [
    "method": METHOD_NAME,
    "api_key": API_KEY,
    "gallery_id": GALLERY_ID,
    "extras": EXTRAS,
    "format": DATA_FORMAT,
    "nojsoncallback": NO_JSON_CALLBACK
]
[After the user presses the "Grab New Image" button] For convenience, we place the arguments used for the flickr.galleries.getPhotos method into a dictionary. This will be used by the escapedParameters() function.

/* 3 - Initialize session and url */
let session = NSURLSession.sharedSession()
let urlString = BASE_URL + escapedParameters(methodArguments)
let url = NSURL(string: urlString)!
let request = NSURLRequest(URL: url)
Now, we grab the singleton instance of NSURLSession and create the URL and an instance of NSURLRequest.

/* 4 - Initialize task for getting data */
let task = session.dataTaskWithRequest(request) { data, response, downloadError in
    // handle the response...
})
Using the session and request, we instantiate our task for grabbing an image from Flickr. The completion handler block is commented-out here, but this is where we will work with the response data.

/* 5 - Success! Parse the data */
var parsingError: NSError? = nil
let parsedResult: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &parsingError)
In the completion handler, we parse the JSON response data into something we can use -- we will cover this in more detail in Lesson 2.

/* 6 - Grab a single, random image */
let randomPhotoIndex = Int(arc4random_uniform(UInt32(photoArray.count)))
let photoDictionary = photoArray[randomPhotoIndex] as [String: AnyObject]
Since our request will return JSON for multiple images in gallery 5704-72157622566655097, we just grab one of the images.

/* 7 - Get the image url and title */
let photoTitle = photoDictionary["title"] as? String
let imageUrlString = photoDictionary["url_m"] as? String
let imageURL = NSURL(string: imageUrlString!)
Then, we grab the selected image's title and URL.

/* 8 - If an image exists at the url, set the image and title */
if let imageData = NSData(contentsOfURL: imageURL!) {
    dispatch_async(dispatch_get_main_queue(), {
        self.photoImageView.image = UIImage(data: imageData)
        self.photoTitle.text = photoTitle
    })
} else {
    println("Image does not exist at \(imageURL)")
}
If there is data at the URL, then we update the photoImageView and photoTitle!

/* 9 - Resume (execute) the task */
task.resume()
This actually runs/executes our request. Up to this point, all the previous steps just define what we should do when the request runs and completes.
```

### Lesson 1 Terms

* Networking
* Hypertext Transfer Protocol (HTTP)
* Uniform Resource Locator (URL)
* HTTP GET method
* Web services and APIs

## Lessons Learned

### What is a UIWebView?

UIWebView - embed web content into your app. Can use this class to move forward and backward in web history. Can set some web content properties programmatically.

* Create UIWebView object
* Attach it to a window
* Send it a request to load web content

### What are collection types?

Swift provides three primary collection types, known as arrays, sets, and dictionaries, for storing collections of values. 

* Arrays are ordered collections of values.
* Sets are unordered collections of unique values.
* Dictionaries are unordered collections of key-value associations.

<https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/CollectionTypes.html>

### What is a defer statement in Swift 2.0?

Rather than using nested if statements, a defer statement allows us to create a block that handles code that will be executed once execution leaves the current scope.

For example, this could be useful if we need to perform certain operations before deallocating memory. Defer can allow us to execute deallocation code no matter which exit point is used to return from the current function.

<http://nshipster.com/guard-and-defer/>

### What is a class cluster?

* Class clusters are a design pattern that the Foundation framework makes extensive use of. 
* Class clusters group a number of private concrete subclasses under a public abstract superclass. T
* Class clusters are based on the Abstract Factory design pattern.

Ex: To illustrate the class cluster architecture and its benefits, consider the problem of constructing a class hierarchy that defines objects to store numbers of different types (char, int, float, double). Because numbers of different types have many features in common (they can be converted from one type to another and can be represented as strings, for example), they could be represented by a single class. However, their storage requirements differ, so it’s inefficient to represent them all by the same class. 

![](https://developer.apple.com/library/ios/documentation/General/Conceptual/CocoaEncyclopedia/Art/cluster1.gif "Class cluster example")

### What is NSJSONSerialization?

You use the NSJSONSerialization class to convert JSON to Foundation objects and convert Foundation objects to JSON.

### What is NSJSONReadingAllowFragments?

Specifies that the parser should allow top-level objects that are not an instance of NSArray or NSDictionary.

`
NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
`

### What is the difference between concrete subclass and subclass?

Looking up documentation, I often run into wording that says, “[className] is a subclass of [className]” or “[className] is a concrete subclass of [className]” so in this case I wondered the difference.

A concrete subclass is one you can instantiate.
If it’s not concrete, you can’t instantiate an object of that class.

In the case of NSURLSessionDataTask, they say it is concrete because it subclasses an abstract class (NSURLSessionTask).
NSHTTPURLResponse is already a concrete class because it subclasses a concrete class (NSURLResponse) which is also why they don’t mention it explicitly.

### Explain the steps for making a request.
NSURLSessionDataTask - Concrete subclass of NSURLSessionTask
The NSURLSessionTask class is the base class for tasks in a URL session. Tasks are always part of a session; you create a task by calling one of the task creation methods on an NSURLSession object. The method you call determines the type of task.

URL sessions provide three types of tasks: data tasks, upload tasks, and download tasks. These tasks are instances of the NSURLSessionDataTask, NSURLSessionUploadTask, and NSURLSessionDownloadTask subclasses of NSURLSessionTask, respectively.

* Data tasks request a resource, returning the server’s response as one or more NSData objects in memory. They are supported in default, ephemeral, and shared sessions, but are not supported in background sessions.
* Upload tasks are like data tasks, except that they make it easier to provide a request body so you can upload data before retrieving the server’s response. Additionally, upload tasks are supported in background sessions.
* Download tasks download a resource directly to a file on disk. Download tasks are supported in any type of session.

NSHTTPURLResponse, subclass of NSURLResponse
The NSHTTPURLResponse class is a subclass of NSURLResponse that provides methods for accessing information specific to HTTP protocol responses. Whenever you make HTTP URL load requests, any response objects you get back from the NSURLSession, NSURLConnection, or NSURLDownload class are instances of the NSHTTPURLResponse class.

NSURL, from the urlString / string of methodArguments
NSURLRequest

### What are 2XX codes?

2xx - 200 status codes mean success of some sort

Study these forever: <https://www.flickr.com/photos/girliemac/sets/72157628409467125/>

### When creating a new project in Xcode, can I use periods?

Project names with a “.” turn into a dash. Okay.

### What does URI stand for?

Uniform Resource Identifier

### What is an NSURL?

In Foundation, URLs are represented by NSURL.

NSURL instances are created using the NSURL(string:) initializer:

If the string is not a valid URL, the initializer will return nil.

```
Objective-C
NSURL *url = [NSURL URLWithString:@“http://example.com”];
```

```
Swift
let url = NSURL(string: “http://example.com/“)
```

### Construct example URLs from a string relative to a base URL.

NSURL(string:relativeToURL:) - construct a URL from a string relative to a base URL. Be careful of leading /’s in relative paths.

```
Objective-C
NSURL *baseURL = [NSURL URLWithString:@“http://example.com/v1/“];

[NSURL URLWithString:@“foo” relativeToURL:baseURL];
// http://example.com/v1/foo

[NSURL URLWithString:@“foo?bar=baz” relativeToURL:baseURL];
// http://example.com/v1/foo?bar=baz

[NSURL URLWithString:@“/foo” relativeToURL:baseURL];
// http://example.com/foo

[NSURL URLWithString:@“foo/“ relativeToURL:baseURL];
// http://example.com/v1/foo/

[NSURL URLWithString:@“/foo/“ relativeToURL:baseURL];
// http://example.com/foo/

[NSURL URLWithString:@“http://example2.com/“ relativeToURL:baseURL];
// http://example2.com/
```
```
Swift
let baseURL = NSURL(string: “http://example.com/v1/“)

NSURL(string: “foo”, relativeToURL:baseURL)
NSURL(string: “foo?bar=baz”, relativeToURL:baseURL)
NSURL(string: “/foo”, relativeToURL:baseURL)
NSURL(string: “foo/“, relativeToURL:baseURL)
NSURL(string: “/foo/“, relativeToURL:baseURL)
NSURL(string: “http://example2.com/“, relativeToURL:baseURL)
```

### What is the difference between NSURL and NSURLComponents?

The difference here, between NSURL and NSURLComponents, is that component properties are read-write. This provides a safe and direct way to modify individual components of a URL:

* scheme
* user
* password
* host
* port
* path
* query
* fragment

Quietly added in iOS 7 and OS X Mavericks was NSURLComponents, which can best be described by what it could have been named instead: NSMutableURL.

Although username & password can be stored in a URL, consider using NSURLCredential when representing user credentials, or persisting them to the keychain.

### How do you add Percent-Encoding?

```
Objective-C
NSString *title = @“NSURL / NSURLComponents”;
NSString *escapedTitle = [title stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
components.query = [NSSTring stringWithFormat:@“title=%@“, escapedTitle];
```
```
Swift
let title = “NSURL / NSURLComponents”
if let escapedTitle = title.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) {
	components.query = “title=\(escapedTitle)”
}
```

### What is a File Descriptor?
In simple words, when you open a file, the operating system creates an entry to represent that file and store the information about that opened file. So if there are 100 files opened in your OS then there will be 100 entries in OS (somewhere in kernel). These entries are represented by integers like (...100, 101, 102....). This entry number is the file descriptor. So it is just an integer number that uniquely represents an opened file in operating system. If your process opens 10 files then your Process table will have 10 entries for file descriptors.

Similarly when you open a network socket, it is also represented by an integer and it is called Socket Descriptor. I hope you understand.
<http://stackoverflow.com/questions/5256599/what-are-file-descriptors-explained-in-simple-terms>

Hear it from the Horse's Mouth : APUE (Richard Stevens).
To the kernel, all open files are referred to by File Descriptors. A file descriptor is a non-negative number.
When we open an existing file or create a new file, the kernel returns a file descriptor to the process. The kernel maintains a table of all open file descriptors, which are in use. The allotment of file descriptors is generally sequential and they are alloted to the file as the next free file descriptor from the pool of free file descriptors. When we closes the file, the file descriptor gets freed and is available for further allotment.
See this image for more details :
http://lh6.ggpht.com/honestyhuang/SGTZuft4tXI/AAAAAAAAAmA/JBqgZq2dBAU/s800/two%20process%20same%20file.jpg

When we want to read or write a file, we identify the file with the file descriptor that was returned by open() or create() function call, and use it as an argument to either read() or write().
It is by convention that, UNIX System shells associates the file descriptor 0 with Standard Input of a process, file descriptor 1 with Standard Output, and file desciptor 2 with Standard Error.
File descriptor ranges from 0 to OPEN_MAX.
For more information, go through 3rd chapter of APUE Book.
