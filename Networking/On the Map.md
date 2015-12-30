# On the Map

## MapKit Framework

### MKMapView
This is the view that displays a map.

### MKMapViewDelegate
The view controller conforms to this protocol to respond to pin taps.

### MKPointAnnotation
The class that is used to hold the data for the pins. The map view can be supplied with an array of annotation objects.

### How does the map generate the red pins?

The MKPinAnnotationView class provides a concrete annotation view that displays a pin icon like the ones found in the Maps application. Using this class, you can configure the type of pin to drop and whether you want the pin to be animated into place.

### What is the difference between MKAnnotation and MKPointAnnotation?

The MKAnnotation protocol is used to provide annotation-related information to a map view.

The MKPointAnnotation class defines a concrete annotation object located at a specified point. Inherits from NSObject.


## Core Location Framework

### What is a CLLocationCoordinate2D?

Location objects:
```
  init(coordinate coordinate: CLLocationCoordinate2D,
          altitude altitude: CLLocationDistance,
horizontalAccuracy hAccuracy: CLLocationAccuracy,
  verticalAccuracy vAccuracy: CLLocationAccuracy,
            course course: CLLocationDirection,
             speed speed: CLLocationSpeed,
         timestamp timestamp: NSDate)
```
CLLocationCoordinate2D - A structure that contains a geographical coordinate using the WGS 84 reference frame. It takes two CLLocationDegrees (lat lon).

The MKPointAnnotation has a coordinate property that accepts a CLLocationCoordinate2D structure.


## Parse

Parse is a common solution used by mobile apps for persisting data in the cloud as an alternative to using Core Data.

### What is REST?
REpresentational State Transfer API (Twitter, Google, etc) - Works like a website does, make a call from a client to a server and you get data back over an HTTP protocol.

##Summary

* MKMapViewDelegate - When adding a MapView with annotations, create the pinView/MKPinAnnotationView (this creates the actual pins you see on the map). Implement the method calloutAccessoryControlTapped to allow action. The UIControl object is what allows it to be actionable. The UIApplication instance is what helps call openURL on the given NSURL to open the URL in a browser.

## Questions

### Why is the UIApplication needed?

NSURL URLs can be used for interapplication communication. The UIApplication class provides the openURL method.

```
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.sharedApplication()
            if let toOpen = view.annotation?.subtitle! {
                app.openURL(NSURL(string: toOpen)!)
            }
        }
    }
```

