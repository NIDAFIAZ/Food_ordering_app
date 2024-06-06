# **🍕 Food Ordering App 🍔**

A simple and intuitive food ordering Flutter application using SQLite for local data storage. This app allows users to view a list of delicious food items, add items to a cart, and generate a bill. It demonstrates basic CRUD (Create, Read, Update, Delete) operations using SQLite in a Flutter application.

---

## **📱 Features**

- **View Food Items:** Displays a list of food items with images, names, and prices.
- **Add to Cart:** Allows users to add food items to a cart with a single tap.
- **Delete Food Item:** Enables the deletion of specific food items from the database.
- **Generate Bill:** Calculates and displays the total price of items in the cart.
- **SQLite Database:** Utilizes SQLite for local storage of food items.

---

## **🚀 Getting Started**

### **Prerequisites**

- [Flutter](https://flutter.dev/docs/get-started/install) installed on your machine.
- An Android or iOS device/emulator for running the app.

### **Installation**

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/food_ordering_app.git
   cd food_ordering_app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Add assets:**
   Ensure that you have the following image files in the `assets` directory:
   - `assets/kabab.png`
   - `assets/pizza.jpg`
   - `assets/salad.png`
   - `assets/toast.png`

   The `pubspec.yaml` file should include these assets:
   ```yaml
   flutter:
     assets:
       - assets/kabab.png
       - assets/pizza.jpg
       - assets/salad.png
       - assets/toast.png
   ```

4. **Run the app:**
   ```bash
   flutter run
   ```

---

## **📂 Project Structure**

- **lib/main.dart:** Entry point of the application.
- **lib/models/food_item.dart:** Data model for food items.
- **lib/screens/food_item_list_screen.dart:** UI screen to display the list of food items.
- **lib/screens/cart_screen.dart:** UI screen to display the cart and generate the bill.
- **lib/database/database_helper.dart:** Helper class for SQLite database operations.

---

## **🛠️ How to Use**

1. **View Food Items:** Launch the app to see a list of available food items with their images and prices.
2. **Add to Cart:** Tap on the "+" button next to a food item to add it to the cart.
3. **View Cart:** Navigate to the cart screen to see the list of items added to the cart.
4. **Generate Bill:** View the total price of the items in the cart and generate a bill.
5. **Delete Food Item:** Use the delete functionality to remove specific food items from the database.

---


## **📧 Contact**

For any inquiries or feedback, please reach out to nidafiaz1234@gmail.com.

