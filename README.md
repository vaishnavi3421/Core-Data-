

# Core Data To-Do List App

A simple to-do list application using Core Data in Swift.

## Features

### List Display
- A `UITableView` shows a list of to-do items stored in **Core Data**.
- Each cell represents a task.

### Adding New Items
- A `+` button allows users to add new tasks.
- A pop-up alert with a text field appears for input.
- Once submitted, the new task is saved to **Core Data** and displayed in the list.

### Editing Items
- A long press or swipe action opens an **edit/delete menu**.
- Users can modify the task name and save the changes.

### Deleting Items
- Users can delete a task via a **contextual menu**.
- The item is removed from **Core Data**, and the table view updates.

## Core Components in Swift
- **`UITableViewController`** – Displays tasks in a list.
- **`UIAlertController`** – Used for adding/editing items.
- **Core Data (`NSManagedObjectContext`)** – Stores to-do list items persistently.
- **CRUD Operations** – Functions for Create, Read, Update, and Delete items.

## Screenshots
![Image](https://github.com/user-attachments/assets/1993f917-d817-44dd-9862-587b9d9ecfff)

