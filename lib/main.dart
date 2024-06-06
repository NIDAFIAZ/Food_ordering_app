// lib/main.dart

import 'package:flutter/material.dart';
import 'package:food_ordering_app/db/database_helper.dart';
import 'package:food_ordering_app/models/food_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Ordering App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FoodItemListScreen(),
    );
  }
}

class FoodItemListScreen extends StatefulWidget {
  @override
  _FoodItemListScreenState createState() => _FoodItemListScreenState();
}

class _FoodItemListScreenState extends State<FoodItemListScreen> {
  final dbHelper = DatabaseHelper();
  List<FoodItem> foodItems = [];
  List<FoodItem> cartItems = [];

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    final items = await dbHelper.getFoodItems();
    if (items.isEmpty) {
      // Insert sample food items into the database
      for (var item in sampleFoodItems) {
        await dbHelper.insertFoodItem(item);
      }
    }
    _fetchFoodItems();
  }

  Future<void> _fetchFoodItems() async {
    final items = await dbHelper.getFoodItems();
    setState(() {
      foodItems = items;
    });
  }

  void _addFoodItem() {
    showDialog(
      context: context,
      builder: (context) {
        final _nameController = TextEditingController();
        final _priceController = TextEditingController();
        final _imageUrlController = TextEditingController();

        return AlertDialog(
          title: Text('Add Food Item'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Price (Rupees)'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _imageUrlController,
                  decoration: InputDecoration(labelText: 'Image URL'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final name = _nameController.text;
                final price = double.tryParse(_priceController.text) ?? 0.0;
                final imageUrl = _imageUrlController.text;
                final newFoodItem = FoodItem(name: name, price: price, imageUrl: imageUrl);
                await dbHelper.insertFoodItem(newFoodItem);
                _fetchFoodItems();
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _deleteFoodItem(int id) async {
    await dbHelper.deleteFoodItem(id);
    _fetchFoodItems();
  }

  void _addToCart(FoodItem item) {
    setState(() {
      cartItems.add(item);
    });
  }

  void _generateBill() {
    double total = cartItems.fold(0.0, (sum, item) => sum + item.price);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Bill'),
          content: Text('Total: ${total.toStringAsFixed(2)} Rupees'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _viewCart() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Cart'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: cartItems.map((item) => Text('${item.name}: ${item.price.toStringAsFixed(2)} Rupees')).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Items'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addFoodItem,
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: _viewCart,
          ),
          IconButton(
            icon: Icon(Icons.receipt),
            onPressed: _generateBill,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          final item = foodItems[index];
          return Card(
            child: ListTile(
              leading: Image.asset(
                item.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(item.name),
              subtitle: Text('${item.price.toStringAsFixed(2)} Rupees'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    onPressed: () => _addToCart(item),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteFoodItem(item.id!),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
