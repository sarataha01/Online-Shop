import 'package:flutter/material.dart';
import 'package:online_shop/services/product_services.dart';

import '../components/cart_button.dart';
import '../components/product_container.dart';
import '../components/product_details.dart';
import '../components/profile_button.dart';
import '../models/product_model.dart';

class MyProduct extends StatefulWidget {
  const MyProduct({super.key});

  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  bool _isLoading = true;
  MyProducts? dataFromAPI;

  void _productDetailPage(Product product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(product: product),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    dataFromAPI = await ProductServices.fetchProducts();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
        leading: const ProfileButton(),
        actions: const [CartButton()],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : dataFromAPI == null
              ? const Center(
                  child: Text("Failed to load data"),
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: dataFromAPI!.products.length,
                  itemBuilder: (context, index) {
                    final product = dataFromAPI!.products[index];
                    return InkWell(
                      onTap: () {
                        _productDetailPage(product);
                      },
                      child: ProductContainer(product: product),
                    );
                  },
                ),
    );
  }
}
