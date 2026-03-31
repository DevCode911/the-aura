# 🌟 The Aura – Flutter App

A scalable Flutter application built using **GetX architecture**, designed for service browsing, booking, and user interaction with a clean and modular structure.

---

## 📱 Overview

**The Aura** is a feature-rich mobile application that allows users to:

* Browse services and categories
* View detailed service information
* Add items to cart
* Manage profiles and favorites
* Complete onboarding & authentication

The project follows a **clean, modular architecture** using GetX for state management, dependency injection, and routing.

---

## 🏗️ Architecture

This project follows a **layered architecture**:

```
Presentation (View)
↓
Bindings (Dependency Injection)
↓
Controllers (Business Logic)
↓
Repositories (Data Handling)
↓
Services / API Layer
```

---

## 📂 Project Structure

### 🔹 Core Structure

```
lib/
├── bindings/            # GetX dependency bindings
├── controller/          # Business logic (GetX controllers)
├── data/                # API services & exception handling
├── models/              # Basic data models
├── repository/          # Data repositories
├── view/                # UI screens/pages
├── view_models/         # Feature-based models & controllers
├── utils/               # Reusable widgets & helpers
├── res/                 # Themes, routes, constants
├── services/            # API service layer
```

---

### 🔹 Key Modules

#### 📌 Bindings

* Handles dependency injection using GetX
* Example:

    * `add_cart_binding.dart`
    * `service_binding.dart`
    * `view_product_binding.dart`

---

#### 📌 Controllers

* Contains business logic for each feature
* Examples:

    * Cart management
    * Profile editing
    * OTP handling
    * Navigation state

---

#### 📌 Repository Layer

* Acts as a bridge between controllers and API
* Organized by features:

    * `category_repository.dart`
    * `service_repository.dart`
    * `advertisement_repository.dart`

---

#### 📌 View (UI Layer)

* Contains all screens:

    * Home
    * Services
    * Booking
    * Profile
    * Auth (Login / OTP / Signup)
    * Wishlist

---

#### 📌 View Models

* Feature-specific structured logic & models
* Keeps UI clean and maintainable

---

#### 📌 Utils (Reusable Components)

* Custom widgets:

    * Buttons
    * App bars
    * Text fields
    * Snackbars
    * Dialogs

---

#### 📌 Resources (`res/`)

* App theming
* Routes management
* API URLs

---

## 🚀 Features

* 🔐 Authentication (OTP, Login, Signup)
* 🛍️ Add to Cart functionality
* ❤️ Wishlist management
* 📦 Service & package browsing
* 📄 Service details view
* 👤 Profile management
* 📱 Responsive UI support
* 🎯 Clean navigation using GetX routes

---

## ⚙️ Tech Stack

* **Flutter**
* **Dart**
* **GetX (State Management + Routing + DI)**
* **REST API Integration**
* **Firebase (configured)**

---

## 🧩 State Management

This project uses **GetX** for:

* State management
* Dependency injection
* Route management

---

## 🔌 API Layer

* Located in: `data/network_api_service.dart`
* Handles:

    * API requests
    * Error handling
    * Response parsing

---

## ▶️ Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/the_aura.git
cd the_aura
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run the App

```bash
flutter run
```

---

## 🔥 Firebase Setup

Make sure Firebase is configured:

* `firebase_options.dart` is already included
* Add your platform-specific configs:

    * `google-services.json` (Android)
    * `GoogleService-Info.plist` (iOS)

---

## 🧪 Testing

```bash
flutter test
```

## 👨‍💻 Author

* Devang Patel

---

## 💡 Future Improvements

* 🔔 Push notifications
* 🌙 Dark mode support
* 💳 Payment integration
* 🌐 Multi-language support
* 📊 Analytics dashboard
