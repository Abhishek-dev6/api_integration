import 'dart:convert';
//import 'package:api_example/model/products_model.dart';
import 'package:api_integration/model/products_model.dart';
import 'package:http/http.dart' as http;

class RepositoryProducts {
  final String baseurl = "https://api.restful-api.dev/objects";
  Future<List<Products>> fetchproducts() async {
    final response = await http.get(Uri.parse(baseurl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((e) => Products.fromJson(e)).toList();
    } else {
      throw Exception("Failed to Fetch Products");
    }
  }

  Future<Products> addproducts(Products product) async {
    final response = await http.post(
      Uri.parse(baseurl),
      headers: {'content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Products.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to add products");
    }
  }

  Future<void> deleteProduct(String id) async {
    final url=Uri.parse("https://api.restful-api.dev/objects/{id}");
    final response = await http.delete(url);
    if (response.statusCode != 200) {
      throw Exception("Failed to delete");
    }
  }
}
