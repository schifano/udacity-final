# Lesson 2 - Presenting View Controllers

Presenting stock view controllers:

* Camera Roll / Image Picker View
* Activity View
* Alert View (does not come with a cancel button built in)

### Image Picker Controller
```
@IBAction func experiment1() {
	let imagePickerController = UIImagePickerController()
   self.presentViewController(imagePickerController, animated: true, completion: nil)
}
```  

### Activity View Controller

```  
@IBAction func experiment2() {
	let image = UIImage()
	let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
	self.presentViewController(activityController, animated: true, completion: nil)        
}
```    

### Alert View Controller

```
@IBAction func experiment3() {
	let alertController = UIAlertController()
	alertController.title = "Test Alert"
	alertController.message = "This is a test alert"
        
	// Create closure to add OK button for user
	let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) {
		action in self.dismissViewControllerAnimated(true, completion: nil)
	}
        
	alertController.addAction(okAction)
	self.presentViewController(alertController, animated: true, completion: nil)
}
```

### Present View Controllers Programmatically

Make sure that the ViewController has an identifier in storyboard

1. Open Storyboard
2. Select the yellow circle icon for the DiceViewController
3. Open the Identity Inspector
4. Set the Storyboard ID

```
// Example
IBAction func rollTheDice() {
    // Get the DiceViewController

    var controller: DiceViewController

    controller = self.storyboard?.instantiateViewControllerWithIdentifier("DiceViewController") as! DiceViewController

    // Set the two values to random numbers from 1 to 6
    controller.firstValue = self.randomDiceValue()
    controller.secondValue = self.randomDiceValue()

    // Present the view Controller
    self.presentViewController(controller, animated: true, completion: nil)
}
```

### 2015-08-02 13:50:43.813 Roshambo[7783:883810] Warning: Attempt to present <Roshambo.ResultViewController: 0x7f98a2c81b70> on <Roshambo.BeginMatchViewController: 0x7f98a2f07d60> whose view is not in the window hierarchy!

One window on your phone, at all times. The views don't count.

<http://stackoverflow.com/questions/11862883/whose-view-is-not-in-the-window-hierarchy>

Where are you calling this method from? I had an issue where I was attempting to present a modal view controller within the viewDidLoad method. The solution for me was to move this call to the viewDidAppear: method.

My presumption is that the view controller's view is not in the window's view hierarchy at the point that it has been loaded (when the viewDidLoad message is sent), but it is in the window hierarchy after it has been presented (when the viewDidAppear: message is sent).

## Quiz Questions

### For the following user interface items, indicate whether there is a preference for navigation (N) or modal (M) presentation.

UI Item | Presentation
------- | ------------
A self contained task that should be completed or abandoned | M
A hierarchy of options in which users make one choice per page and retrace their steps | N
Alert messages | M
A list of items, with a detail page associated with each | N

## Example Apps

* OffTheShelf View Presentation
* Dice
* Roshambo (Rock Paper Scissors)