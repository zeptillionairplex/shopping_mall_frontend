// lib/providers/cart_provider.dart
import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];
  final ProductService _productService = ProductService();

  List<CartItem> get items => _items;

  double get totalPrice => _items.fold(0, (total, item) => total + item.product.price * item.quantity);

  void addToCart(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      _items[index].increment();
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  Future<void> addToCartById(int productId) async {
    try {
      final product = await _productService.fetchProduct(productId);
      addToCart(product);
    } catch (e) {
      print('Error adding product to cart: $e');
    }
  }

  void removeFromCart(int productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  Future<void> removeFromCartById(int productId) async {
    try {
      final index = _items.indexWhere((item) => item.product.id == productId);
      if (index != -1) {
        _items.removeAt(index);
        notifyListeners();
      } else {
        print('Item with productId $productId not found in cart');
      }
    } catch (e) {
      print('Error removing product from cart: $e');
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  /// 수량 업데이트 기능
  Future<void> updateCartItemQuantity(int productId, int quantity) async {
    try {
      final index = _items.indexWhere((item) => item.product.id == productId);
      if (index != -1) {
        if (quantity > 0) {
          _items[index].quantity = quantity; // 수정 부분
        } else {
          _items.removeAt(index);
        }
        notifyListeners();
      } else {
        print('Item with productId $productId not found in cart');
      }
    } catch (e) {
      print('Error updating cart item quantity: $e');
    }
  }

  Future<void> syncCart() async {
    try {
      for (var cartItem in _items) {
        final product = await _productService.fetchProduct(cartItem.product.id!);
        cartItem.product = product;
      }
      notifyListeners();
    } catch (e) {
      print('Error syncing cart: $e');
    }
  }

  /// 수량 변경 기능 추가
  void updateQuantity(int productId, int newQuantity) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      _items[index].quantity = newQuantity > 0 ? newQuantity : 1;
      notifyListeners();
    }
  }
}