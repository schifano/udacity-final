# Lesson 2 - Building Flick Finder

### What are the basic steps for parsing JSON?

1. Get the raw JSON data
2. Parse the JSON data into a Foundation object (NSDictionary, NSArray)
3. Grab the data from the Foundation object


### What is the magic behind the ability to tap the screen and dismiss a keyboard?

UITapGestureRecognizer

```
var tapRecognizer: UITapGestureRecognizer? = nil
```

### List JSON Types to Swift Types

Here is a simple mapping JSON types to Swift types (JSON ==> Swift):

* null ==> nil
* Number ==> Int, Float, Double, ...
* String ==> String
* Boolean ==> Bool
* Array ==> [AnyObject]
* Object ==> [String:AnyObject]
* Nesting objects (dictionaries) ==> [[String:AnyObject]]

Note the use of AnyObject for arrays and objects. You will likely want a more specific type; however, for safety, it is a good idea to start by parsing values as AnyObject and then optionally casting them to more specific types.

### Why not use the doubleValue property to convert an NSString to a Double?

In FlickFinder, we check to see if the provided textfield longitude and latitude is valid. 

The instructor suggested the following:

```
if let latitude : Double? = self.latitudeTextField.text!.toDouble()
```

Which produced the error:

`
Value of type 'String' has no member 'toDouble'
`

This prompted me to research valid ways to convert a String to a Double. There were many suggestions listed here <http://stackoverflow.com/questions/24031621/swift-how-to-convert-string-to-double>, many of which first convert the String to NSString to use doubleValue().

```
(self.latitudeTextField.text! as NSString).doubleValue
```

Interestingly, the NSString doubleValue property is not recommended because it can return 0 if the value cannot be converted. This could mean that the user provided bad input. 

Instead, the Swift 2.0 suggestion would be to initialize a Double and use that value.

```
if let latitude = Double(self.latitudeTextField.text!)
```


## Lesson 2 Reference Sheet

### Terms

Javascript Object Notation (JSON)

### Concepts

* Built networking app step-by-step
* Constructed and called web service method
* Parsed JSON data from HTTP response
* Populated view using data from HTTP response
* Read an API's documentation to solve an issue

### Code Snippets

```
Get the NSURLSessions singleton

let session = NSURLSession.sharedSession()
```

```
Create and run a NSURLSessionDataTask

let url = NSURL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=d72c5a85006014ea74022c115e4ebd5b&text=test&format=json&nojsoncallback=1&auth_token=72157650613647678-32c4dc1af8b80f31&api_sig=0353bdf97603872c2c2338390da3793d")!

let request = NSURLRequest(URL: url)

let task = session.dataTaskWithRequest(request) { data, response, downloadError in
    // do something here...
}

task.resume()
```

```
Parse raw JSON data into NSDictionary (if response is a dictionary)

var parsingError: NSError? = nil
let parsedResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &parsingError) as NSDictionary
```