class MyProducts {
  List<Product> products;
  double total;
  int skip;
  int limit;

  MyProducts({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory MyProducts.fromJson(Map<String, dynamic> json) => MyProducts(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        total: json["total"]?.toDouble() ?? 0.0,
        skip: json["skip"] ?? 0,
        limit: json["limit"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
      };
}

class Product {
  int id;
  String title;
  String description;
  double price;
  double discountPercentage;
  double rating;
  int stock;
  String brand;
  String category;
  String thumbnail;
  List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] ?? 0,
        title: json["title"] ?? 'No Title',
        description: json["description"] ?? 'No Description',
        price: json["price"]?.toDouble() ?? 0.0,
        discountPercentage: json["discountPercentage"]?.toDouble() ?? 0.0,
        rating: json["rating"]?.toDouble() ?? 0.0,
        stock: json["stock"] ?? 0,
        brand: json["brand"] ?? 'Unknown Brand',
        category: json["category"] ?? 'Unknown Category',
        thumbnail: json["thumbnail"] ?? '',
        images: json["images"] != null
            ? List<String>.from(json["images"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "discountPercentage": discountPercentage,
        "rating": rating,
        "stock": stock,
        "brand": brand,
        "category": category,
        "thumbnail": thumbnail,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}
