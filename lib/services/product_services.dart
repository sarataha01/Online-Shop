import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';

class ProductServices {
  static Future<void> addToCart(BuildContext context, Product product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartItems = prefs.getStringList('cartItems');

    cartItems ??= [];
    Map<String, dynamic> productDetails = {
      'title': product.title,
      'price': product.price,
      'thumbnail': product.thumbnail,
    };
    String productDetailsJson = jsonEncode(productDetails);
    cartItems.add(productDetailsJson);

    await prefs.setStringList('cartItems', cartItems);

    SnackBar snackBar = const SnackBar(
      content: Text("Added successfully!"),
      duration: Duration(seconds: 2),
    );
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  static Future<MyProducts?> fetchProducts() async {
    try {
      String endpoint = "https://dummyjson.com/products";
      http.Response res = await http.get(Uri.parse(endpoint));

      if (res.statusCode == 200) {
        MyProducts dataFromAPI = MyProducts.fromJson(json.decode(res.body));
        return dataFromAPI;
      } else {
        // Handle other status codes if needed
        return null;
      }
    } catch (e) {
      debugPrint("Error: $e");
      return null;
    }
  }
}
