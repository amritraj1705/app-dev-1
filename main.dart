// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'product_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        home: LaunchScreen(),
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 190, 75, 75),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
      ),
    );
  }
}

class LaunchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
          ),
        ],
      ),
      body: ProductList(),
    );
  }
}

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Product> products = [
      Product(image: 'assets/watch.jpg', name: 'Titan Watch', price: 6295),
      Product(
          image: 'assets/books.jpg',
          name: 'A Song Of Ice and Fire Collection',
          price: 2500),
      Product(
          image: 'assets/iphone.jpg',
          name: 'Apple Iphone 13(512GB) - Blue',
          price: 61999),
      Product(
          image: 'assets/earphones.jpg',
          name: 'OnePlus Bluetooth Wireless Z2',
          price: 1999),
      Product(image: 'assets/shirt.jpg', name: 'H&M Shirt', price: 1499),
      Product(
          image: 'assets/bottle.jpg', name: 'Water Bottle(Blue)', price: 8999),
      Product(
          image: 'assets/headphones.jpg',
          name: 'BoAt Headphones (Black)',
          price: 1199),
      Product(
          image: 'assets/speaker.jpg',
          name: ' JBL Charge 5 Portable Bluetooth Speaker',
          price: 14590),
      Product(
          image: 'assets/charger.jpg',
          name: 'RDG Apple 20W Superfaast Charger',
          price: 1099),
      Product(
          image: 'assets/wallpaper.jpg',
          name: 'Naruto HD Wallpaper',
          price: 399),
      Product(image: 'assets/blanket.jpg', name: 'Winter Blankets', price: 800),
    ];

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 251, 66, 125),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                'What is on your wishlist today?',
                style: TextStyle(
                  color: Color.fromARGB(255, 14, 14, 14),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 2,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        product.image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      product.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('\₹${product.price.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: product.addedToCart
                          ? Icon(Icons.check, color: Colors.green)
                          : Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        CartProvider cartProvider =
                            Provider.of<CartProvider>(context, listen: false);
                        if (product.addedToCart) {
                          cartProvider.removeFromCart(product);
                        } else {
                          cartProvider.addToCart(product);
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    List<Product> cartItems = cartProvider.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          Product product = cartItems[index];
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              leading: Image.asset(
                product.image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text(
                product.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('\₹${product.price.toStringAsFixed(2)}'),
              trailing: IconButton(
                icon: Icon(Icons.remove_shopping_cart),
                onPressed: () {
                  cartProvider.removeFromCart(product);
                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Amount: \₹${cartProvider.totalCartPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                cartProvider.clearCart();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 243, 227, 239),
              ),
              child: Text(
                'BUY',
                style: TextStyle(color: Color.fromARGB(255, 179, 170, 0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
