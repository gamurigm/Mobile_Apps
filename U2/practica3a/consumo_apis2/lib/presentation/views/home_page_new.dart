import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/producto_viewmodel.dart';
import '../../domain/entities/producto_entity.dart';
import 'theme/colores_esquema.dart';
import 'widgets/organisms/organisms.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProductoViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Productos"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => vm.cargarProductos(),
            tooltip: 'Recargar',
          ),
        ],
      ),
      body: vm.loading
          ? const LoadingState()
          : vm.productos.isEmpty
              ? const EmptyProductState()
              : _buildProductList(context, vm),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showProductDialog(context, vm, null),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Producto'),
      ),
    );
  }

  Widget _buildProductList(BuildContext context, ProductoViewModel vm) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: vm.productos.length,
      itemBuilder: (_, i) {
        final p = vm.productos[i];
        return ProductCard(
          product: p,
          onEdit: () => _showProductDialog(context, vm, p),
          onDelete: () => _showDeleteConfirmation(context, vm, p),
          onTap: () => _showProductDialog(context, vm, p),
        );
      },
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    ProductoViewModel vm,
    ProductoEntity product,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => DeleteConfirmDialog(
        productName: product.nombre,
        onConfirm: () {
          vm.deleteProductos(product.id);
          Navigator.pop(ctx);
        },
        onCancel: () => Navigator.pop(ctx),
      ),
    );
  }

  void _showProductDialog(
    BuildContext context,
    ProductoViewModel vm,
    ProductoEntity? product,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => ProductFormDialog(
        title: product == null ? "Agregar Producto" : "Editar Producto",
        initialName: product?.nombre,
        initialPrice: product?.precio,
        initialStock: product?.stock,
        initialCategory: product?.categoria,
        onCancel: () => Navigator.pop(ctx),
        onSave: (nombre, precio, stock, categoria) {
          if (product == null) {
            // Create
            final newProduct = ProductoEntity(
              id: '',
              nombre: nombre,
              precio: precio,
              stock: stock,
              categoria: categoria,
            );
            vm.createProductos(newProduct);
          } else {
            // Update
            final updatedProduct = ProductoEntity(
              id: product.id,
              nombre: nombre,
              precio: precio,
              stock: stock,
              categoria: categoria,
            );
            vm.updateProductos(product.id, updatedProduct);
          }
          Navigator.pop(ctx);
        },
      ),
    );
  }
}
