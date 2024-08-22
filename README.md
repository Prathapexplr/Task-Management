Task Management App
A comprehensive Flutter app for managing tasks, integrating with provided APIs, and following clean code principles. The app allows users to register, log in, create, view, edit, and delete tasks with additional features like offline storage and performance optimizations.

Features
User Authentication:
Register new users using the provided API.
Log in existing users and persist user sessions.
Task Management:
Create, view, edit, and delete tasks.
Tasks include attributes such as title, description, due date, priority, status, and assigned user.
Offline storage using SQLite or Hive, ensuring functionality even without an internet connection.
Performance Optimization:
Lazy loading for data lists.
Efficient state management using the Provider package.
Complex Forms:
Task creation/editing forms with the following fields:
Title (Text)
Description (Text)
Due Date (Date Picker)
Priority (Dropdown with options: High, Medium, Low)
Status (Dropdown with options: To-Do, In Progress, Done)
Assigned User (Dropdown populated from the User Information API)
Form validation to ensure data integrity.
State Management:
State management implemented using the Provider package for efficient and smooth user experience.
Clean Code:
Meaningful names, small functions, and single responsibility principles followed.
Proper error handling throughout the application.
Well-documented code adhering to Dart’s style guide.
UI/UX:
Clean, modern, and responsive user interface.
Custom animations to enhance user experience, including smooth screen transitions and task animations.
Error Handling:
Robust error handling for API calls, authentication, and form submissions.
User-friendly error messages.
Technologies Used
Flutter SDK: 3.16.9
Dart SDK: 3.2.6
State Management: Provider package
APIs Used:
Reqres API: For user authentication and user information.
JSONPlaceholder API: For task management (static API used for demonstration).
