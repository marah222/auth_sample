# auth_sample

Flutter Sign-Up Flow Implementation,Clean Architecture
===================================

This repository contains a fully functional, multi-step sign-up module for a conceptual "Workiom" application. The project was built from the ground up to serve as a high-quality technical demonstration of modern Flutter development practices.

The primary focus is on creating a scalable, maintainable, and testable codebase by strictly adhering to **Clean Architecture**, **SOLID principles**, and a component-based **Design System**.

 Screenshots
--------------

The user journey consists of four main screens:

1.  **Welcome Screen:** Options to sign up with Google or Email.
    
2.  **Password Screen:** Secure password entry with real-time validation against server-side rules.
    
3.  **Company Details Screen:** User and company name registration with a debounced API check for workspace availability.
    
4.  **Thank You Screen:** A confirmation screen upon successful registration.
    
Key Features
--------------

*   **Multi-Step Sign-Up Flow:** Guides the user through a logical sequence of registration steps.
    
*   **Real-time Form Validation:** Provides instant feedback on email format and password strength.
    
*   **Debounced API Calls:** Efficiently checks for workspace name availability without spamming the server.
    
*   **Centralized State Management:** Manages all UI logic, validation, and API interactions cleanly.
    
*   **Reusable Design System:** Ensures a consistent and beautiful user interface.
    

Technical Architecture
--------------------------

This project is a practical implementation of a feature-based Clean Architecture.

*   **Architecture Pattern:** **Clean Architecture**
    
    *   **Domain Layer:** Contains the core business logic (entities, use cases, abstract repositories). It is completely independent of any framework or data source.
        
    *   **Data Layer:** Implements the repository contracts from the domain layer. It handles all communication with the remote API.
        
    *   **Presentation Layer:** Contains all the UI elements (Widgets), along with BLoCs to manage the UI state.
        
*   **State Management:** **flutter\_bloc** is used to manage the state of the application, cleanly separating business logic from the UI.
    
*   **Dependency Injection:** **get\_it** is used as a service locator to provide dependencies (like Repositories and BLoCs) throughout the widget tree.
    
*   **Networking:** The **dio** package is used for all HTTP requests to the backend API.
    
*   **Code Principles:** The codebase adheres to **SOLID**, **DRY** (Don't Repeat Yourself), and is built with modularity in mind.
    

🎨 Design System
----------------

A core principle of the project is the complete separation of styling from UI logic.

*   **AppColors:** A single source of truth for the entire application color palette.
    
*   **AppTypography:** Centralized text styles, configured via a TextTheme.
    
*   **AppTheme:** A global theme that applies consistent styling to all widgets.
    
*   **Reusable Widgets:** A library of custom widgets (AppTextField, AppButton, etc.) in the core/design\_system/widgets directory ensures UI consistency and rapid development.
  
