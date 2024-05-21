// lib/providers/product_provider.dart
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _productService = ProductService();
  List<Product> _products = [];
  Product? _selectedProduct;
  final Map<int, Product?> _cache = {};

  List<Product> get products => _products;
  Product? get selectedProduct => _selectedProduct;

  Future<void> fetchProducts({bool forceRefresh = false}) async {
    try {
      if (_products.isEmpty || forceRefresh) {
        _products = await _productService.fetchProducts();
        // 각 제품을 캐시에 저장
        for (var product in _products) {
          _cache[product.id!] = product;
        }
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Future<Product?> fetchProduct(int id) async {
    if (_cache.containsKey(id)) {
      return _cache[id];
    }

    try {
      _selectedProduct = await _productService.fetchProduct(id);
      _cache[id] = _selectedProduct;
      notifyListeners();
      return _selectedProduct;
    } catch (e) {
      print('Error fetching product with ID $id: $e');
      return null;
    }
  }

  Future<Product?> fetchProductByName(String name) async {
    try {
      _selectedProduct = await _productService.fetchProductByName(name);
      if (_selectedProduct != null) {
        _cache[_selectedProduct!.id!] = _selectedProduct;
      }
      notifyListeners();
      return _selectedProduct;
    } catch (e) {
      print('Error fetching product with name $name: $e');
      return null;
    }
  }

  Future<void> createProduct(Product product) async {
    try {
      final newProduct = await _productService.createProduct(product);
      _products.add(newProduct);
      _cache[newProduct.id!] = newProduct;
      notifyListeners();
    } catch (e) {
      print('Error creating product: $e');
    }
  }

  Future<void> updateProduct(int id, Product product) async {
    try {
      final updatedProduct = await _productService.updateProduct(id, product);
      final index = _products.indexWhere((p) => p.id == id);
      if (index != -1) {
        _products[index] = updatedProduct;
        _cache[id] = updatedProduct;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating product with ID $id: $e');
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      await _productService.deleteProduct(id);
      _products.removeWhere((p) => p.id == id);
      _cache.remove(id);
      notifyListeners();
    } catch (e) {
      print('Error deleting product with ID $id: $e');
    }
  }
}