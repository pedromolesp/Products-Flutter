import 'dart:convert';

import 'package:formvalidation/src/models/product_model.dart';

import 'package:http/http.dart' as http;

class ProductProvider {
  final String _url = "https://flutter-varios-689ec.firebaseio.com";

  Future<bool> createProduct(ProductModel product) async {
    final url = "$_url/productos.json";
    final response = await http.post(url, body: productModelToJson(product));
    final decodedData = json.decode(response.body);
    print(decodedData);
    return true;
  }

  Future<bool> updateProduct(ProductModel product) async {
    final url = "$_url/productos/${product.id}.json";
    final response = await http.put(url, body: productModelToJson(product));
    final decodedData = json.decode(response.body);
    print(decodedData);
    return true;
  }

  Future<List<ProductModel>> loadProducts() async {
    final url = "$_url/productos.json";
    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductModel> products = List();
    if (decodedData == null) return [];

    decodedData.forEach((key, value) {
      final prod = ProductModel.fromJson(value);
      prod.id = key;

      products.add(prod);
    });
    return products;
  }

  Future<int> deleteProduct(String id) async {
    final url = "$_url/productos/$id.json";
    final resp = await http.delete(url);
    print(resp.body);
    return 1;
  }
}
