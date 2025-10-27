Youtube Presentation: https://youtu.be/jnUiYPSsM9Q
	AI LOG USAGE

Question 1 — October 18th
“How might I implement my main.dart file so that it connects all screens together, manages navigation, and supports a light/dark theme toggle?”
My Learning (from my perspective):

With ChatGPT’s guidance, I learned how to implement a main.dart file that serves as the entry point for my Flutter app.
I used a StatefulWidget so that I could dynamically toggle between light and dark themes using Flutter’s built-in ThemeData.light() and ThemeData.dark() configurations.
I also set up the MaterialApp widget with named routes to connect all my screens:
•	/ opens the Home Screen,
•	/second opens the User List Screen,
•	/third opens the Weekly List Generator Screen.
This taught me how named routes, MaterialApp, and setState() work together to control both navigation and theme appearance consistently throughout the entire app.
________________________________________
Question 2 — October 18th
“How might I implement a home_screen.dart file that acts as the starting page of the app and allows users to navigate to the grocery list and weekly list generator screens?”
My Learning (from my perspective):

I learned how to design a Home Screen that serves as the central navigation hub of my app.
It includes buttons that use Navigator.pushNamed() to move between the User List (/second) and Weekly List Generator (/third) screens.
I also implemented two key features:
•	A Theme Toggle Button that calls a callback function from main.dart to switch between dark and light mode.
•	An Accessibility Button that toggles a global variable (animationsEnabled) stored in a separate globals.dart file. This allows users who are sensitive to visual effects to turn off all in-app animations.
This process helped me understand Flutter navigation, callback functions between widgets, and how to create accessible UI controls that affect other parts of the app globally.
________________________________________
Question 3 — October 24th
“How might I implement the weekly_list_generator_screen.dart so that it generates a default set of grocery items and saves them into the SQLite database?”
My Learning (from my perspective):

I learned that the Weekly List Generator should dynamically create a random grocery list by pulling items directly from my database (DBHelper).
With ChatGPT’s help, I implemented a function that:
1.	Fetches all existing grocery items from SQLite,
2.	Randomly shuffles them,
3.	Selects five items to form a new weekly list,
4.	Assigns each item a random quantity (1–5) and a random priority tag.
I also created an Accept button that replaces the global grocery list with the new weekly list and displays a confirmation AlertDialog to inform the user.
This taught me how to combine database operations, randomization, and global state management in one interactive feature using Dart’s Random() class and Flutter’s UI state system.
________________________________________
Question 4 — October 23th
“How might I implement a search bar and filter function to search for grocery items by name, and also add an approval/non-approval system for each item on the item list screen?”
My Learning (from my perspective):

I learned how to implement a real-time search and filter system in Flutter using a TextField widget and the .where() filtering method on a list of grocery items.
The _searchQuery variable stores the user’s input, and the UI updates instantly using setState() as the user types.
By converting both the search text and item names to lowercase, the search became case-insensitive for better usability.
I also implemented an approval system using Flutter’s Switch widget.
Each item has a boolean field approved, and toggling the switch updates that value in the SQLite database through the DBHelper.updateItem() method.
When toggled, the card briefly performs a bounce animation (using AnimatedScale) to visually indicate change — unless the user has disabled animations from the home screen for accessibility.
Through this, I learned how to connect UI interactivity with database persistence, synchronize state across widgets, and design features that adapt to accessibility preferences.
________________________________________
Question 5 — Implementing Priority Tags: October 24th
“How might I implement different priority tags (‘I don’t need,’ ‘I kinda need,’ and ‘I need now’) for grocery items, using a dropdown box on the edit or add-item screen and saving that choice to the database?”

My Learning (from my perspective):
I learned how to use Flutter’s DropdownButtonFormField widget to allow users to select a priority tag for each grocery item.
Each priority option — “I don’t need,” “I kinda need,” or “I need now” — is stored as a String field in the data model (GroceryItem) and saved in the SQLite database through DBHelper.
The selected value is displayed both on the User List Screen (with color-coded text based on urgency) and in the Edit Item Screen, where it can be modified.
This taught me how to add new attributes to my data model, synchronize dropdown values with the database, and use conditional colors (like red for urgent items) to visually represent data importance.
________________________________________
Question 6 - October 25th — Global Variable Sharing (Globals File)
“I have a flutter project where I have 2 files. Both files have their own list of items, but I want to be able to update file 2's list with file 1's list. How could I achieve this?”
My Learning (from my perspective):

With ChatGPT’s help, I learned how to create a dedicated globals.dart file to store global variables that can be shared and modified across multiple screens.
In this file, I defined variables such as:
List<GroceryItem> groceryItems = [];
List<GroceryItem> weeklyList = [];
bool animationsEnabled = true;
This allowed my Weekly List Generator Screen to directly update the global grocery list on the User List Screen, so changes are reflected app-wide.
I also used the same global variable (animationsEnabled) to control accessibility animations across the app.
Through this, I learned how to manage shared state between screens effectively, without passing data manually through constructors or context, making my code cleaner and more scalable.

