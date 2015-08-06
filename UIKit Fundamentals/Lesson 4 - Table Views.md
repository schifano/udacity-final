# Lesson 4 - Table Views

Familiar UITableViews

* Health Data
* Maps
* Albums

Tables use two protocols:

1. UITableViewDelegate - has 33 methods
2. UITableViewDataSource - has 11 methods

Tables are a cornerstone of UIKit and very customizable, thus the huge method count.

###TableView Delegate Method Signatures

**UITextFieldDelegate**

```
func textField(textField: UITextField, shouldChangeCharactersInRange: NSRange, 
				replacementString string: String) -> Bool
				
External argument name: replacementString
Internal argument name: string
```

**UITableViewDelegate**

```
func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool

External argument name: canEditRowAtIndexPath
Internal argument name: indexPath

Struct has two members:
1. row
2. section
```

### Challenge in the implementation of scrolling through tables.

Tables need optimization. iPhone users want to be able to swipe along a list quickly. Each row is a fairly complex view object, having to swipe through hundreds of rows, that is a lot of objects to allocate. Apple worked out a caching scheme to reuse cell objects.

Anything that is shared across cells get reused: cell border, image placement, recurring control elements, recurring labels, structure of cells data, etc. Don't need to be respecified when they come on the screen, only data.

At any given time, there will be a few table view cell objects off the screen in a queue waiting to come back on screen with new data.

The queue is kept inside the table view, whenever we need a cell, we dequeue one from the table view and populate it with data. Queues are sorted by reuseIdentifier: different cells are in different queues.

This process is like stairs on an escalator, when cell objects scroll off the screen, they will be reused on other side.

cellForRowIndexPath - IndexPath is a struct that holds the row number

Data Source Protocol - Only required methods:
cellForRowAtIndexPath
UITableView asks datasource, numberOfRowsInSection


### UITableViews and Storyboard

1. Add a table to the main view (drag below status bar)
2. Add constraints
3. Connect the table's datasource property:  
Note: Open the connection popup menu for the view that has the property. In this case the Table View has the dataSource property.
Drag from the properties connection circle to the object that the property should refer to, in this case, the view controller.
4. Create a prototype cell (set from 0 to 1)
5. Set the cell’s reuse identifier

Prototype Cells:

* Basic
* Right Detail
* Left Detail
* Subtitle
* Custom

## Quiz Questions

### Which method signatures correspond to the following questions?

* How many rows?  
`func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int`
* What is the cell for each row?  
`func cellForRowAtIndexPath(_ indexPath: NSIndexPath) -> UITableViewCell?`
* What should happen when a cell is selected?
`func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)`

---

### Which of the following models might be used to construct the "Albums" table?

* An array of structs
* An array of dictionaries

---

### If you could only ask three of these questions and you needed to build a single section table, which would you pick?

UITableViewDelegate - Responses to user events

* What should happen when a button in a cell is tapped?
* **What should be the response to the cell selection? (1)**  
* How should I respond when a user begins editing a row?
* What should happen when a cell is deselected?

UITableViewDataSource - Access to data and cells

* **How many rows do I have? (2)**
* How many sections do I have?
* What are the titles for the sections?
* **What is the cell view for each row? (3)**

---

### For each method, think about the question the view is asking it's delegate.

### Configuring Rows for the Table View

Method 			| Question 		| Usage
:----------- | :----------- | :---------
tableView:heightForRowAtIndexPath: | Asks the delegate for the height to use for a row in a specified location. | The method allows the delegate to specify rows with varying heights.
tableView:estimatedHeightForRowAtIndexPath: | Asks the delegate for the estimated height of a row in a specified location. | Providing an estimate the height of rows can improve the user experience when loading the table view.
tableView:indentationLevelForRowAtIndexPath: | Asks the delegate to return the level of indentation for a row in a given section. | Kittens
tableView:willDisplayCell:forRowAtIndexPath: | Tells the delegate the table view is about to draw a cell for a particular row. | A table view sends this message to its delegate just before it uses cell to draw a row, thereby permitting the delegate to customize the cell object before it is displayed.


### Managing Accessory Views

Method 			| Question 		| Usage
:----------- | :-----------  | :---------
tableView:editActionsForRowAtIndexPath: | Asks the delegate for the actions to display in response to a swipe in the specified row. (required) | Use this method when you want to provide custom actions for one of your table rows. 
tableView:accessoryTypeForRowWithIndexPath: | Asks the delegate for the type of standard accessory view to use as a disclosure control for the specified row. | Deprecated in iOS 3.0
tableView:accessoryButtonTappedForRowWithIndexPath: | Tells the delegate that the user tapped the accessory (disclosure) view associated with a given row. | The delegate usually responds to the tap on the disclosure button (the accessory view) by displaying a new view related to the selected row.

### Managing Selections
Method 			| Question 		| Usage
:----------- | :-----------  | :---------
tableView:willSelectRowAtIndexPath: | Tells the delegate that a specified row is about to be selected. | This method is not called until users touch a row and then lift their finger; the row isn't selected until then, although it is highlighted on touch-down.
tableView:didSelectRowAtIndexPath: | Tells the delegate that the specified row is now selected. | The delegate handles selections in this method.
tableView:willDeselectRowAtIndexPath: | Tells the delegate that a specified row is about to be deselected. | This method is only called if there is an existing selection when the user tries to select a different row.
tableView:didDeselectRowAtIndexPath: | Tells the delegate that the specified row is now deselected. | The delegate handles row deselections in this method.

### Modifying the Header and Footer of Sections

Method 			| Question 		| Usage
:----------- | :-----------  | :---------
tableView:viewForHeaderInSection: | Asks the delegate for a view object to display in the header of the specified section of the table view. | The returned object can be a UILabel or UIImageView object, as well as a custom view.
tableView:viewForFooterInSection: | Asks the delegate for a view object to display in the footer of the specified section of the table view. | The returned object can be a UILabel or UIImageView object, as well as a custom view.
tableView:heightForHeaderInSection: | Asks the delegate for the height to use for the header of a particular section. | This method allows the delegate to specify section headers with varying heights.
tableView:estimatedHeightForHeaderInSection: | Asks the delegate for the estimated height of the header of a particular section. | Providing an estimate the height of section headers can improve the user experience when loading the table view. If the table contains variable height section headers, it might be expensive to calculate all their heights and so lead to a longer load time. Using estimation allows you to defer some of the cost of geometry calculation from load time to scrolling time.
tableView:heightForFooterInSection: | Asks the delegate for the height to use for the footer of a particular section. | This method allows the delegate to specify section footers with varying heights. The table view does not call this method if it was created in a plain style (UITableViewStylePlain).
tableView:estimatedHeightForFooterInSection: | Asks the delegate for the estimated height of the footer of a particular section. | Providing an estimate the height of section footers can improve the user experience when loading the table view. If the table contains variable height section footers, it might be expensive to calculate all their heights and so lead to a longer load time. Using estimation allows you to defer some of the cost of geometry calculation from load time to scrolling time.
tableView:willDisplayHeaderView:forSection: | Tells the delegate that a header view is about to be displayed for the specified section. | Kittens
tableView:willDisplayFooterView:forSection: | Tells the delegate that a footer view is about to be displayed for the specified section. | Kittens

### Editing Table Rows

Method 			| Question 		| Usage
:----------- | :-----------  | :---------
tableView:willBeginEditingRowAtIndexPath: | Tells the delegate that the table view is about to go into editing mode. | This method is called when the user swipes horizontally across a row; as a consequence, the table view sets its editing property to YES (thereby entering editing mode) and displays a Delete button in the row identified by indexPath.
tableView:didEndEditingRowAtIndexPath: | Tells the delegate that the table view has left editing mode. | This method is called when the table view exits editing mode after having been put into the mode by the user swiping across the row identified by indexPath.
tableView:editingStyleForRowAtIndexPath: | Asks the delegate for the editing style of a row at a particular location in a table view. | This method allows the delegate to customize the editing style of the cell located at indexPath.
tableView:titleForDeleteConfirmationButtonForRowAtIndexPath: | Changes the default title of the delete-confirmation button. | By default, the delete-confirmation button, which appears on the right side of the cell, has the title of “Delete”.
tableView:shouldIndentWhileEditingRowAtIndexPath: | Asks the delegate whether the background of the specified row should be indented while the table view is in editing mode. | If the delegate does not implement this method, the default is YES.

### Reordering Table Rows

Method 			| Question 		| Usage
:----------- | :-----------  | :---------
tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath: | Asks the delegate to return a new index path to retarget a proposed move of a row. | This method allows customization of the target row for a particular row as it is being moved up and down a table view.


### Tracking the Removal of Views

Method 			| Question 		| Usage
:----------- | :-----------  | :---------
tableView:didEndDisplayingCell:forRowAtIndexPath: | Tells the delegate that the specified cell was removed from the table. | Use this method to detect when a cell is removed from a table view, as opposed to monitoring the view itself to see when it appears or disappears.
tableView:didEndDisplayingHeaderView:forSection: | Tells the delegate that the specified header view was removed from the table. | Use this method to detect when a header view is removed from a table view, as opposed to monitoring the view itself to see when it appears or disappears.
tableView:didEndDisplayingFooterView:forSection: | Tells the delegate that the specified footer view was removed from the table. | Use this method to detect when a footer view is removed from a table view, as opposed to monitoring the view itself to see when it appears or disappears.

### Copying and Pasting Row Content

Method 			| Question 		| Usage
:----------- | :-----------  | :---------
tableView:shouldShowMenuForRowAtIndexPath: | Asks the delegate if the editing menu should be shown for a certain row. | If the user tap-holds a certain row in the table view, this method (if implemented) is invoked first.
tableView:canPerformAction:forRowAtIndexPath:withSender: | Asks the delegate if the editing menu should omit the Copy or Paste command for a given row. | This method is invoked after tableView:shouldShowMenuForRowAtIndexPath:. It gives the developer the opportunity to exclude one of the commands—Copy or Paste—from the editing menu. For example, the user might have copied some cell content from one row but wants to paste into another row that doesn’t take the copied content. In a case like this, return NO from this method.
tableView:performAction:forRowAtIndexPath:withSender: | Tells the delegate to perform a copy or paste operation on the content of a given row. | The table view invokes this method for a given action if the user taps Copy or Paste in the editing menu.

### Managing Table View Highlighting

Method 			| Question 		| Usage
:----------- | :-----------  | :---------
tableView:shouldHighlightRowAtIndexPath: | Asks the delegate if the specified row should be highlighted. | As touch events arrive, the table view highlights rows in anticipation of the user selecting them.
tableView:didHighlightRowAtIndexPath: | Tells the delegate that the specified row was highlighted. | Kittens
tableView:didUnhighlightRowAtIndexPath: | Tells the delegate that the highlight was removed from the row at the specified index path. | Kittens

---

### Which method did we use the most to customize the textfields?

`textField(_:shouldChangeCharactersInRange: replacementString:)`

---

### How does UITableView know how many rows it has?

By asking its data source, more specifically, by invoking the data source protocol method, numberOfRowsInSection.

---

### What is the implementation that belongs to the following code?

```
func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell { }
```

```
let cell = tableView.dequeueReusableCellWithIdentifier("FavoriteThingCell") as UITableViewCell
cell.textLabel?.text = self.favoriteThings[indexPath.row]
return cell
```

### iOS App Examples

Favorite Things

Do Re Me

Bond Villains

Roshambo With History

