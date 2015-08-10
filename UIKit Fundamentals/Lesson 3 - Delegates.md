# Lesson 3 - Delegates

### Delegate

An object that executes a group of methods on behalf of another object.

The ability to reuse views without needing to subclass or modify them is an important goal of all graphical user interface libraries.

View classes used as is - control and model classes to have the freedom to customize those views.

The delegate is considered a **design pattern** (yay). General design patterns also work with iOS of course, but there are unique design patterns such as the delegate.

### Protocols

The view establishes questions that need to be answered, and encodes them in a protocol to be answered by the delegate.

The view's delegate is usually going to be a control object.  Control objects are designed to perform tasks like passing user input to a data model.

The key to the delegate pattern is that the view establishes the questions that it needs answersed and encodes them in a protocol. A protocol is a list of methods that a delegate must implement. Any object that fulfills the protocol can become a delegate.

#### Analogies

*Electric plug*: Any object that implements a standard electric plug protocol can receive electricity from a corresponding socket. Note that different regions of the world implement the electric plug protocol in different ways, but they all share basic components.

### Control Flow Walkthrough

1. User taps the keyboard
2. Textfield realizes text will change
3. Textfield invokes...  
```
textField(_ : shouldChangeCharactersInRange: replacementString )
```
4. VC receives invocation
5. VC assembles the new text
6. VC updates the label
7. VC returns "true" to allow change

## Quiz Questions

### If we swapped the delegates around between textfields, would the behavior of the textfields change?

```
// Three delegates
self.textField1.delegate = emojiDelegate
self.textField2.delegate = colorizeDelegate
self.textField3.delegate = self

```

Yes, the custom behavior is provided by the delegate. We can do this because the text fields are identical and the only differences are provided by the delegate.

---

### For each of the seven methods, consult the documentation and provide an example implementation. Post one or two of your examples to the discussion forum.


```
// This method notifies the delegate that the specified text field just became the first responder.
func textFieldDidBeginEditing(textField: UITextField) {
	// Clears the current textfield text
	textField.text = ""
}
```

```
// The text field calls this method whenever the user taps the return button.
// Anytime a keyboard starts editing, it becomes the first responder. That's why touches on the keyboard occurs in the current textview not all of them.
func textFieldShouldReturn(textField: UITextField) -> Bool {
	// Dismisses the keyboard
	textField.resignFirstResponder()
	return true
}
```

## TIL: TextFields App

###Why do some classes in TextFields inherit NSObject and others do not?

Swift classes do not inherit from NSObject. View Controllers already inherit from NSObject, so adding a delegate protocol like UITextFieldDelegate is okay without also inheriting NSObject. However, other Swift files, such as EmojiTextFieldDelegate or RandomColorTextFieldDelegate, must inherit from NSObject.

```
/* Examples */
ViewController.swift

// Contains code for the counter delegate
class ViewController.swift: UIViewController, UITextFieldDelegate { }

EmojiTextFieldDelegate.swift
class EmojiTextFieldDelegate: NSObject, UITextFieldDelegate { }

```

---

###Why use UInt32() in the following code?

```
var colorChoice: Int = Int(arc4random() % UInt32(colors.count))
```

UInt32(colors.count) is casting the int value returned by the count of the colors array into an UInt32 type. Using arc4random() returns a type of UInt32. In order to operate using % (remainder operator) the two values have to be compatible.

---

###What is going on with that unicodeScalars method?

In the Udacity forums, they were discussing the general idea of this snippet of code. However, I had to dig a lot deeper to feel satisfied (as usual).

From the current text, they retrieve only the numerical values, ignoring all punctuation. To do this, they use an NSCharacterSet which you can specify a more specific subset of only decimal digits (so numbers). Then, in the newText, they iterate through each character checking if that character is a member of the decimal digits. However, because NSCharacterSet is the set of all possible unicode values, unicodeScalars is what helps return the unicode equivalent of that character from newText that is being checked. Essentially, they have to be the same type in order to find a match.


```
        let digits = NSCharacterSet.decimalDigitCharacterSet()
        var digitText = ""
        
        for c in newText.unicodeScalars {
            if digits.longCharacterIsMember(c.value) {
                digitText.append(c)
            }
        }
```

Term | Description
----- | -------
NSCharacterSet.decimalDigitCharacterSet() | The set of all characters used to represent the decimal values 0 through 9. These characters include, for example, the decimal digits of the Indic scripts and Arabic.
longCharacterIsMember | Returns a Boolean value that indicates whether a given long character is a member of the receiver.
Unicode Scalars | A Unicode scalar is a unique 21-bit number for a character or modifier, such as U+0061 for LATIN SMALL LETTER A ("a"), or U+1F425 for FRONT-FACING BABY CHICK ("🐥").
newText.unicodeScalars | The value of self as a collection of Unicode scalar values <http://www.unicode.org/glossary/#unicode_scalar_value> var unicodeScalars: String.UnicodeScalarView -> A collection of Unicode scalar values <http://www.unicode.org/glossary/#unicode_scalar_value> that encode a String .

---

### Why do we return false early?

Returning true gives the text field permission to update automatically. Since we are trying to manually update the text field with our newly formatted string, then we return false. Otherwise, if we update the text field manually AND return true,  there will be twice as many values updated in the text field.

func textField(textField: UITextField, shouldChangeCharactersInRange...) is a method that gives permission to the text view to update / change text.

```        
        // Format the new string
        if let numOfPennies = digitText.toInt() {
            newText = "$" + self.dollarStringFromInt(numOfPennies) + "." + self.centsStringFromInt(numOfPennies)
        } else {
            newText = "$0.00"
        }
        
        textField.text = newText
        
        return false
    }
```

---

### How do I restrict the user to typing numbers?

There are default keyboards for that. You can use Numbers, which will bring up a number pad, or Numbers and Punctuation for...numbers and punctuation.

---

### Why use CGFloat, why not just Float?

CGFloat is actaully architecturally dependent! Pretty cool.

The following snippet from SO is really great info:

<http://stackoverflow.com/questions/1264924/whats-the-difference-between-using-cgfloat-and-float>

CGFloat is just a typedef for either float or double. CGFloat is a regular float on 32-bit systems and a double on 64-bit systems

```
typedef float CGFloat;// 32-bit
typedef double CGFloat;// 64-bit
```

So you won't get any performance penalty.

There are times that straight primitives can be problematic, such as if a variable may conceivably be used to store data which could overflow, such as on 64-bit. In general, using architecture-dependent typedefs is safer, in that code is less likely to explode on a different architecture. However, sometimes using a 32-bit type can be completely safe and save you memory. The size of primitives may be less of an issue in a JVM, but Obj-C and C are compiled, and mixing 32 and 64 bit libraries and code is indeed problematic. 

## Udacity Example Apps

Goal is to use delegates to create many different customized behaviors using one view.

Text Fields App - git checkout step3.1-textFieldsApp
Text Fields Challenge App - git checkout step3.2-textFieldsChallengeApp-solution
