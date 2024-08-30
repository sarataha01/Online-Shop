import 'package:flutter/material.dart';

import '../pages/cart.dart';

class CartButton extends StatelessWidget {
  const CartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      highlightColor: Colors.transparent,
      icon: const Icon(Icons.shopping_cart),
      splashRadius: 15,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyCart(),
          ),
        );
      },
    );
  }
}
