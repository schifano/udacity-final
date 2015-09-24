# Lesson 1 - Networking and Web Services

## Getting data with HTTP

HTTP - hypertext transfer protocol

Protocol

* A way of communicating
* Standard operating procedure
* The rules for communication

HTTP Get Request
Request to a server

writes URL for Udacity homepage
The request is picked up, travels over the network to the server.
The server analyzes the request to make sure that it's valid. It looks for the homepage.
If it can't be found, 404 error code.
Once the response is brought back, the HTTP request is finished.


### HTTP GET Method

If you already know about the HTTP GET method, feel free to continue to the next node.

For those unfamiliar, the HTTP GET method can be used to request data from a server using a Uniform Resource Locator (URL). For example, if you wanted to get the data from this course's overview page, you would use the following request:

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
