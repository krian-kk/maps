# Flutter Product Listing & Mapping App

This Flutter application demonstrates:
- Listing products fetched from a remote API.
- Displaying product locations on Google Maps with markers.
- Calculating and displaying the distance between the user and each product.
- Navigating between screens with smooth animations.
- State management using BLoC.

---

## Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/krian-kk/maps
   cd maps

2. **Run the project**:
   ```bash
   flutter pub get
   flutter run

3. **Run API test cases**:
   ```bash
   flutter test test/product_repository_test.dart

4. **Run Distance unit test cases**:
   ```bash
   flutter test test/distance_test.dart

### Architecture & Project Structure:
In this project we are using clean architecture principles to structure the code and separating the app into distinct layers: Presentation, Domain, and Data.

For this project we are using feature first project structure. Click [here](https://codewithandrea.com/articles/flutter-project-structure/) for more details.

![](/screenshots/scr_project_structure.png)

### State Management:
This project is using BLOC state management framework to manages events and states in the app. Click [here](https://bloclibrary.dev/) for more details regarding bloc.

