class FoodItem {
  int? id;
  String name;
  double price;
  String imageUrl;

  FoodItem({this.id, required this.name, required this.price, required this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  factory FoodItem.fromMap(Map<String, dynamic> map) {
    return FoodItem(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      imageUrl: map['imageUrl'],
    );
  }
}
// Sample food items with local asset images
List<FoodItem> sampleFoodItems = [
  FoodItem(
    id: 1,
    name: 'Pizza',
    price: 1200.0,
    imageUrl: 'assets/pizza.jpg', // Path to the image in assets
  ),
  FoodItem(
    id: 2,
    name: 'Kabab',
    price: 1500.0,
    imageUrl: 'assets/kabab.jpg', // Path to the image in assets
  ),
  FoodItem(
    id: 3,
    name: 'Salad',
    price: 500.0,
    imageUrl: 'assets/salad.jpg', // Path to the image in assets
  ),
  FoodItem(
    id: 4,
    name: 'Toast',
    price: 300.0,
    imageUrl: 'assets/toast.jpg', // Path to the image in assets
  ),
];