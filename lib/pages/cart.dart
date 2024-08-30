import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cachedItems = prefs.getStringList('cartItems');

    if (cachedItems != null) {
      setState(() {
        cartItems = cachedItems.map((item) {
          return Map<String, dynamic>.from(jsonDecode(item));
        }).toList();
      });
    }
  }

  Future<void> clearCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('cartItems');
    setState(() {
      cartItems = [];
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cart Cleared'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Cart"),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(cartItems[index]['thumbnail']),
            title: Text(cartItems[index]['title']),
            subtitle: Text('\$${cartItems[index]['price']}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: clearCartItems,
        child: const Icon(Icons.clear),
      ),
    );
  }
}
