# Lesson 1 - Outlets and Actions


UIButton class, belongs to category of view objects called control objects, turn user actions (like finger taps)into events. The button is a target action. Target action holds three pieces of information:

1. Target, object to notify
2. Action, method to use
3. Event that will trigger the target / action

The term IBAction is derived from target action.

### Target, Action, Event

```
// Add target action(s)
button.addTarget(self, action: "incrementCount", 
forControlEvents: UIControlEvents.TouchUpInside)

Target: self
Action/Method: incrementCount
Event: TouchUpInside
```

```
decrementButton.addTarget(self, action: "decrementCount",
 forControlEvents: UIControlEvents.TouchUpInside)

Target: self
Action/Method: decrementCount
Event: TouchUpInside
```

### Callback Method

Callback method, can configure button so that it can call back when an event occurs (callback to controller). Use view objects to reach back and contact the control objects.

```
// Example Callback Method
button.addTarget(self, action: "incrementCount", 
forControlEvents: UIControlEvents.TouchUpInside)
```


### Actions and Outlets

* **Actions** - method invocations from views back to view controllers.
* **Outlets** - invocations from controller to view.

Storyboard represents objects 3 ways:

1. Expandable Outline View
2. Visual Canvas View
3. Text Editor

@IBOutlet and @IBAction lets Storyboard recognize your code.

## Quiz Questions

### What does the circle in the gutter next to the action indicate?
The circle to the right of the action indicates that this action can be found connected to an object in Storyboard.

---

### What information does the Connections Inspector provide?

The Connections Inspector appears to provide information on Triggered Segues, Outlet Collections, Sent Events, etc. All the information associated with any Storyboard object.

---

### An action is a ...

An action is a **method**.

---

### An outlet is a ...

An outlet is a **property**.

--- 

### What does marking a variable as an IBOutlet do?

Marking a variable as an IBOutlet makes it visible in Storyboard.

---

### Does every view in Storyboard need an outlet? Why or why not?

A view in Storyboard needs an outlet if it needs to be modified programmatically.

---

### Does every view in Storyboard need an actin? Why or why not?

A view in Storyboard needs an action if it is expected to respond to user input.

---

### What is the name of the event which corresponds to a switch being thrown?

ValueChanged

---

### How do we know if a switch is on or off?

"on" property

## Example Apps

* Click Counter
* Color Maker App