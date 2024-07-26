# Clean Architecture Blog App

A modern, efficient blog application built with Flutter, implementing Clean Architecture principles. This app allows users to create and upload blog posts, leveraging Supabase as the backend and BLoC for state management.

## Features

- User authentication
- Create and publish blog posts
- View and interact with published blogs
- Clean Architecture for scalability and maintainability
- Supabase backend for secure and efficient data storage
- BLoC pattern for robust state management

## Architecture

This project follows Clean Architecture principles, separating the codebase into layers:

1. **Presentation Layer**: UI components and BLoC implementations
2. **Domain Layer**: Use cases, entities, and repository interfaces
3. **Data Layer**: Repository implementations, data sources, and models

## Technologies Used

- **Flutter**: UI framework
- **Supabase**: Backend-as-a-Service (BaaS) for authentication and data storage
- **flutter_bloc**: State management
- **get_it**: Dependency injection
- **freezed**: Code generation for immutable classes
- **hive**: To store blogs locally, allows offline access and for caching.

