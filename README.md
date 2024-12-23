# Flutter Product Listing & Mapping App

This Flutter application demonstrates:
- Listing products fetched from a remote API.
- Displaying product locations on Google Maps with markers.
- Calculating and displaying the distance between the user and each product.
- Navigating between screens with smooth animations.
- State management using BLoC.

---

## Features

1. **Product Listing**:
   - Fetch products from the API:  
     `https://h2gvbfqo6smwzaby6x7jinzujm0otrjt.lambda-url.eu-west-2.on.aws/`
   - Show product details such as title, description, image, and distance.
   - Retry option for failed API calls.

2. **Google Maps Integration**:
   - Show all product locations as pins/markers.
   - Clicking a marker displays product title and description.
   - Calculate and display a route from the user's current location to the selected product.

3. **Location Permission**:
   - Request user permission to access location.
   - Handle scenarios when location services are disabled or denied.

4. **Error Handling**:
   - API and location errors are displayed with options to retry.

5. **Animations**:
   - Smooth screen transitions for polished user experience.

6. **Unit Testing**:
   - Unit tests for API calls and distance calculation.

---

## Technologies Used

- **Flutter**: Framework for building cross-platform applications.
- **Dio**: HTTP client for API calls.
- **BLoC**: State management.
- **google_maps_flutter**: Google Maps integration.
- **geolocator**: User location and permission handling.
- **mockito**: Mocking for unit tests.

---

## Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-repository/flutter-product-app.git
   cd flutter-product-app
