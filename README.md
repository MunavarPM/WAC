# MVVM SwiftUI Sample App<br>
This project implements a sample iOS app using SwiftUI and MVVM design pattern.
<br>The app fetches data from a provided API and displays categories, banners, and products dynamically.
<br>It also includes functionality to handle offline mode using CoreData for data storage.

## Features:
 * Dynamic Sections: Display categories, slider banners, single banner, and products dynamically based on API response.
 * Category Display: Fetches category names and images from the API and displays them in the app.
 * Banner Display: Fetches banner images from the API and displays them in a slider format.
 * Product Display: Fetches product details including name, offer amount, actual price, offer price, image, and rating from the API. Displays offer amount as % OFF if greater than 0. Doesn't display offer price if it's the same as the actual price.
* Offline Mode: App can display categories, products, and banners even without an internet connection using CoreData for data storage.
* Bottom Navigation: Includes blank pages for bottom navigation bar action buttons.
## Project Structure:
Model: Contains structures for categories, banners, and products fetched from the API.
ViewModel: Implements MVVM pattern, handles data fetching and processing.
View: SwiftUI views for displaying categories, banners, and products.
Networking: Handles API requests and responses.
Storage: Handles CoreData for offline data storage.
