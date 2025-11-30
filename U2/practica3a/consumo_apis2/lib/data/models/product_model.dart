import '../../domain/entities/producto_entity.dart';

class ProductoModel extends ProductoEntity {
  ProductoModel({
    required String id,
    required String nombre,
    required double precio,
    required int stock,
    required String categoria,
  }) : super(
         id: id,
         nombre: nombre,
         precio: precio,
         stock: stock,
         categoria: categoria,
       );

  factory ProductoModel.fromJson(Map<String, dynamic> json) {
    // Map different possible keys from APIs to the domain entity
    final id = json['id'] ?? json['_id'] ?? '';
    final nombre = json['nombre'] ?? json['title'] ?? '';
    final precioRaw = json['precio'] ?? json['price'] ?? 0;
    final categoria = json['categoria'] ?? json['category'] ?? '';
    final stockRaw = json['stock'] ?? json['cantidad'] ?? 0;

    double precio;
    if (precioRaw is int) {
      precio = precioRaw.toDouble();
    } else if (precioRaw is double) {
      precio = precioRaw;
    } else {
      precio = double.tryParse(precioRaw.toString()) ?? 0.0;
    }

    int stock;
    if (stockRaw is int) {
      stock = stockRaw;
    } else {
      stock = int.tryParse(stockRaw.toString()) ?? 0;
    }

    return ProductoModel(
      id: id.toString(),
      nombre: nombre,
      precio: precio,
      stock: stock,
      categoria: categoria,
    );
  }
}
