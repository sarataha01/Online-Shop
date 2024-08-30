import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductContainer extends StatelessWidget {
  const ProductContainer({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              blurRadius: 0,
              spreadRadius: 1,
            )
          ]),
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Image.network(
              product.thumbnail,
              height: 200,
            ),
          ),
          const SizedBox(height: 10),
          Text(product.title),
          const SizedBox(height: 5),
          Text(
            "\$${product.price.toString()}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
