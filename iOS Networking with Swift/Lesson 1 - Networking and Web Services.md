

Getting data with HTTP

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




Both the api_key and user_id are required to use flickr.people.getPublicPhotos. However, when testing using the API Explorer (as seen in the video), you only need user_id.



Review: "Sleeping in the Library"

If you have not already completed the Finished "Sleeping in the Library"?, do so first.

This review will go over the commented sections in the ViewController.swift file:

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


Lesson 1 Reference Sheet

Here is a summary of things included in this lesson.

Terms

Networking
Hypertext Transfer Protocol (HTTP)
Uniform Resource Locator (URL)
HTTP GET method
Web services and APIs
Concepts

Identified web services by the data they expose
Registered for a web service (Flickr)
Explored a web service's API (Flickr)
Ran a web service method from an iOS app
In this lesson, the implementation was done for you, but in the next lesson you will be writing these yourself


Specification: “Flick Finder”

Overview

“Flick Finder” is an iOS application that allows users to search Flickr for images based on a search string or location. Each search displays a random image and its title from Flickr.

Layout

See prototype image
Functionality

Users can search Flickr's images using a string
String must be non-empty
Display a random image pertaining to the search
If no images exist for the search, notify the user
Users can search Flickr's images using latitude and longitude
Latitude and longitude must be non-empty
Latitude must be provided as a number between -90 and 90
Longitude must be provided as a number between -180 and 180
Display a random image pertaining to the search
If no images exist for the search, notify the user
The app must be laid out in a format that matches the prototype image