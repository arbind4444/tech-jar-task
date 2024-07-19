# techjartask

A new Flutter project.

## Getting Started

This summary provides a detailed overview of how to implement APIs for a Flutter application that lists posts, displays post details along with comments, and allows adding new comments. Additionally, it includes fetching and displaying user-related data such as posts, albums, and todos.

1. Setting Up the API Service

We created an ApiService class to handle all API requests. This class uses the http package to perform network operations.

API Service Methods:

Fetch Posts: Retrieves a list of posts.
Fetch Post Comments: Retrieves comments for a specific post.
Add Comment: Adds a new comment to a specific post.
Fetch Users: Retrieves a list of users.
Fetch User's Posts: Retrieves posts by a specific user.
Fetch User's Todos: Retrieves todos by a specific user.
Fetch User's Albums: Retrieves albums by a specific user.
Fetch Album's Photos: Retrieves photos from a specific album.
Add Todo: Adds a new todo for a specific user.
Update Todo: Updates an existing todo for a specific user.
Delete Todo: Deletes a specific todo for a user.

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
