// Consume con http y Future
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'base_datasource.dart';
import '../models/product_model.dart';

class ProductoApiDataSource implements BaseDataSource {
  // Use localhost for Web/Desktop, 10.0.2.2 for Android Emulator
  final String baseUrl = 'http://localhost:3000/api/productos';
  @override
  Future<List<ProductoModel>> fetchProductos() async {
    final url = Uri.parse(baseUrl);
    final resp = await http.get(url);

    if (resp.statusCode != 200) {
      throw Exception('Error al cargar los productos');
    }
    final List data = json.decode(resp.body);

    return data
        .map<ProductoModel>((item) => ProductoModel.fromJson(item))
        .toList();
  }

  @override
  Future<ProductoModel> createProductos(Map<String, dynamic> data) async {
    final resp = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (resp.statusCode != 201) {
      throw Exception('Error al crear el producto');
    }
    return ProductoModel.fromJson(json.decode(resp.body));
  }

  @override
  Future<bool> deleteProductos(String id) async {
    final resp = await http.delete(Uri.parse("$baseUrl/$id"));

    return resp.statusCode == 200;
  }

  @override
  Future<ProductoModel> updateProductos(
    String id,
    Map<String, dynamic> data,
  ) async {
    final resp = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (resp.statusCode != 200) {
      throw Exception('Error al actualizar el producto');
    }
    return ProductoModel.fromJson(json.decode(resp.body));
  }
}
