import 'dart:math';

import 'package:console_shoppingmaill/product.dart';

class ShoppingMall {
  // 초기 데이터
  List<Product> stores = [
    Product(name: '셔츠', price: 45000, count: 1),
    Product(name: '원피스', price: 30000, count: 2),
    Product(name: '반팔티', price: 500000, count: 3),
    Product(name: '반바지', price: 400000, count: 4),
    Product(name: '양말', price: 300000, count: 0),
  ];

  int totalPrice = 0;
  Map<String, int> bucketProducts = {}; // 장바구니 상품, 수량
  
  // ShoppingMall({required this.stores, required this.totalPrice});

  void showProducts() {
    for(var product in stores) {
      print('${product.name} / 개당 ${product.price}원 / 재고 ${product.count}개');
    }
  }

  bool checkProduct(String? name) {
    return stores.any((element) => element.name == name);
  }

  bool checkProductCount(String? name, int? count) {
    int storedCount = stores.firstWhere((product) => product.name == name).count;
    int bucketCount = bucketProducts[name] ?? 0;
    return storedCount >= (count!+bucketCount);
  }

  void addToCart(String? name, int? count) {
    bucketProducts.update(name!, (x) => x + count!, ifAbsent: () => count!);
    totalPrice += stores.firstWhere((element) => element.name == name).price * count!;
  }

  String showBucketProductNames() {
    return bucketProducts.keys.toString();
  }

  int showTotal() {
    return totalPrice;
  }

  void resetBucket() {
    totalPrice = 0;
    bucketProducts.clear();
  }

  void stockManage() {
    for(var product in stores) {
      if(bucketProducts.containsKey(product.name)) {
        product.count -= bucketProducts[product.name]!;
      }
    }
  }
}
