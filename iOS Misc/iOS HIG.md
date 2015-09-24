# iOS Human Interface Guidelines

## Navigation

"People tend to be unaware of the navigation experience in an app unless it doesn’t meet their expectations. Your job is to implement navigation in a way that supports the structure and purpose of your app without calling attention to itself."

1. Hierarchical
	*  Make one choice per screen until they reach their destination
	* Ex: Settings, Mail
2. Flat
	* Navigate directly from one primary category to another because all primary categories are accessible from the main screen. 
	* Ex: Music and App Store.
3. Content- or experience-driven
	* Users navigate through a book by moving from one page to the next or by choosing a page in the table of contents; in a game, navigation is often an important part of the experience.

### UIKit and UIElements

* **navigation bar** to give users an easy way to traverse a hierarchy of data
	* Show users current position in hierarchy
	* Back button to previous level
* **tab bar** to display several peer categories of content or functionality. 
	* flat information architecture and its persistence lets people switch between categories regardless of their current location
* **page control** when each app screen represents an individual instance of the same type of item or page
	* showing users how many items or pages are available and which one is currently displayed
* In general, it’s best to give users one path to each screen.
	* **Temporary Views** - see in more than one context
		* modal view
		* action sheet
		* alert
* Does not Enable Navigation
	* **Segmented Control**. A segmented control can give users a way to see different categories or aspects of the content on the screen; it doesn’t enable navigation to a new screen.
	* **Toolbar**. Although a toolbar looks similar to a navigation bar or a tab bar, it doesn’t enable navigation. Instead, a toolbar gives users controls that act on the contents of the current screen.