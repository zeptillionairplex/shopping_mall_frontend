// lib/services/product_service.dart

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import '../models/product.dart';
//
// class ProductService {
//   final String baseUrl;
//
//   ProductService() : baseUrl = dotenv.env['API_BASE_URL'] ?? '' {
//     if (baseUrl.isEmpty) {
//       throw Exception('API_BASE_URL is not set in the environment variables.');
//     }
//   }
//
//   Future<List<Product>> fetchProducts() async {
//     final response = await http.get(Uri.parse('$baseUrl/products'));
//
//     if (response.statusCode == 200) {
//       try {
//         List<dynamic> data = json.decode(response.body);
//         return data.map((item) => Product.fromJson(item)).toList();
//       } catch (e) {
//         throw Exception('Failed to parse products data: $e');
//       }
//     } else {
//       throw _handleHttpError(response);
//     }
//   }
//
//   Future<Product> fetchProduct(int id) async {
//     final response = await http.get(Uri.parse('$baseUrl/products/$id'));
//
//     if (response.statusCode == 200) {
//       try {
//         return Product.fromJson(json.decode(response.body));
//       } catch (e) {
//         throw Exception('Failed to parse product data: $e');
//       }
//     } else {
//       throw _handleHttpError(response);
//     }
//   }
//
//   Future<Product> createProduct(Product product) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/products'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode(product.toJson()),
//     );
//
//     if (response.statusCode == 201) {
//       try {
//         return Product.fromJson(json.decode(response.body));
//       } catch (e) {
//         throw Exception('Failed to parse created product data: $e');
//       }
//     } else {
//       throw _handleHttpError(response);
//     }
//   }
//
//   Future<Product> updateProduct(int id, Product product) async {
//     final response = await http.put(
//       Uri.parse('$baseUrl/products/$id'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode(product.toJson()),
//     );
//
//     if (response.statusCode == 200 || response.statusCode == 204) {
//       try {
//         return Product.fromJson(json.decode(response.body));
//       } catch (e) {
//         throw Exception('Failed to parse updated product data: $e');
//       }
//     } else {
//       throw _handleHttpError(response);
//     }
//   }
//
//   Future<void> deleteProduct(int id) async {
//     final response = await http.delete(Uri.parse('$baseUrl/products/$id'));
//
//     if (response.statusCode != 200 && response.statusCode != 204) {
//       throw _handleHttpError(response);
//     }
//   }
//
//   Exception _handleHttpError(http.Response response) {
//     return Exception(
//       'HTTP Error: ${response.statusCode}. Response: ${response.body}',
//     );
//   }
// }
// lib/services/product_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/product.dart';

class ProductService {
  final String baseUrl;

  ProductService() : baseUrl = dotenv.env['API_BASE_URL'] ?? '' {
    if (baseUrl.isEmpty) {
      throw Exception('API_BASE_URL is not set in the environment variables.');
    }
  }

  // 모든 제품을 가져오는 메서드
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      try {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => Product.fromJson(item)).toList();
      } catch (e) {
        throw Exception('Failed to parse products data: $e');
      }
    } else {
      throw _handleHttpError(response);
    }
  }

  // 특정 제품을 가져오는 메서드
  Future<Product> fetchProduct(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$id'));

    if (response.statusCode == 200) {
      try {
        return Product.fromJson(json.decode(response.body));
      } catch (e) {
        throw Exception('Failed to parse product data: $e');
      }
    } else {
      throw _handleHttpError(response);
    }
  }

  // 특정 이름을 가진 제품을 가져오는 메서드
  Future<Product?> fetchProductByName(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/products/name/$name'));

    if (response.statusCode == 200) {
      try {
        return Product.fromJson(json.decode(response.body));
      } catch (e) {
        throw Exception('Failed to parse product by name data: $e');
      }
    } else if (response.statusCode == 404) {
      return null; // 제품을 못 찾은 경우 null 반환
    } else {
      throw _handleHttpError(response);
    }
  }

  // 제품을 생성하는 메서드
  Future<Product> createProduct(Product product) async {
    final response = await http.post(
      Uri.parse('$baseUrl/products'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );

    if (response.statusCode == 201) {
      try {
        return Product.fromJson(json.decode(response.body));
      } catch (e) {
        throw Exception('Failed to parse created product data: $e');
      }
    } else {
      throw _handleHttpError(response);
    }
  }

  // 제품을 업데이트하는 메서드
  Future<Product> updateProduct(int id, Product product) async {
    final response = await http.put(
      Uri.parse('$baseUrl/products/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );

    if (response.statusCode == 200) {
      // 200은 업데이트된 제품 데이터를 반환
      try {
        return Product.fromJson(json.decode(response.body));
      } catch (e) {
        throw Exception('Failed to parse updated product data: $e');
      }
    } else if (response.statusCode == 204) {
      // 204는 성공적으로 업데이트되었으나 데이터는 반환하지 않음
      return await fetchProduct(id);
    } else {
      throw _handleHttpError(response);
    }
  }

  // 제품을 삭제하는 메서드
  Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/products/$id'));

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw _handleHttpError(response);
    }
  }

  // HTTP 에러 핸들러
  Exception _handleHttpError(http.Response response) {
    return Exception(
      'HTTP Error: ${response.statusCode}. Response: ${response.body}',
    );
  }
}