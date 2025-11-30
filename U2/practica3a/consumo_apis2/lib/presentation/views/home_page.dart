import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/producto_viewmodel.dart';
import '../../domain/entities/producto_entity.dart';
import 'package:modern_theme/modern_theme.dart';

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
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    'Cargando productos...',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.txtSecundario,
                    ),
                  ),
                ],
              ),
            )
          : vm.productos.isEmpty
          ? _buildEmptyState(context)
          : _buildProductList(context, vm),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showProductDialog(context, vm, null),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Producto'),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 80,
            color: AppColors.txtTerciario,
          ),
          const SizedBox(height: 16),
          Text(
            'No hay productos',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(color: AppColors.txtPrincipal),
          ),
          const SizedBox(height: 8),
          Text(
            'Agrega tu primer producto',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.txtSecundario),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(BuildContext context, ProductoViewModel vm) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: vm.productos.length,
      itemBuilder: (_, i) {
        final p = vm.productos[i];
        return _buildProductCard(context, vm, p);
      },
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    ProductoViewModel vm,
    ProductoEntity p,
  ) {
    final stockText = p.stock > 0 ? p.stock.toString() : 'N/D';
    final stockColor = p.stock > 10
        ? AppColors.exito
        : p.stock > 0
        ? AppColors.advertencia
        : AppColors.error;

    return Card(
      elevation: 2,
      shadowColor: AppColors.sombra.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.borde.withOpacity(0.5), width: 1),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showProductDialog(context, vm, p),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header con nombre y acciones
              Row(
                children: [
                  Expanded(
                    child: Text(
                      p.nombre,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.txtPrincipal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 20),
                    onPressed: () => _showProductDialog(context, vm, p),
                    tooltip: 'Editar',
                    color: AppColors.primario,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 20),
                    onPressed: () => _showDeleteConfirmation(context, vm, p),
                    tooltip: 'Eliminar',
                    color: AppColors.error,
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Precio destacado
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  gradient: AppColors.gradientePrimario,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '\$${p.precio.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.txtClaro,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Información adicional
              Row(
                children: [
                  // Categoría
                  if (p.categoria.isNotEmpty) ...[
                    Icon(
                      Icons.category_outlined,
                      size: 16,
                      color: AppColors.txtSecundario,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        p.categoria,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.txtSecundario,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],

                  // Stock
                  Icon(Icons.inventory_2_outlined, size: 16, color: stockColor),
                  const SizedBox(width: 4),
                  Text(
                    'Stock: $stockText',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: stockColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    ProductoViewModel vm,
    ProductoEntity product,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: AppColors.advertencia,
          size: 48,
        ),
        title: const Text('¿Eliminar producto?'),
        content: Text(
          '¿Estás seguro de que deseas eliminar "${product.nombre}"? Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              vm.deleteProductos(product.id);
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void _showProductDialog(
    BuildContext context,
    ProductoViewModel vm,
    ProductoEntity? product,
  ) {
    final nombreController = TextEditingController(text: product?.nombre ?? '');
    final precioController = TextEditingController(
      text: product?.precio.toString() ?? '',
    );
    final stockController = TextEditingController(
      text: product?.stock.toString() ?? '',
    );
    final categoriaController = TextEditingController(
      text: product?.categoria ?? '',
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: Icon(
          product == null ? Icons.add_circle_outline : Icons.edit_outlined,
          color: AppColors.primario,
          size: 48,
        ),
        title: Text(product == null ? "Agregar Producto" : "Editar Producto"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(
                  labelText: "Nombre del producto",
                  hintText: "Ej: Laptop HP",
                  prefixIcon: Icon(Icons.shopping_bag_outlined),
                ),
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: precioController,
                decoration: const InputDecoration(
                  labelText: "Precio",
                  hintText: "0.00",
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: stockController,
                decoration: const InputDecoration(
                  labelText: "Stock",
                  hintText: "0",
                  prefixIcon: Icon(Icons.inventory_2_outlined),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: categoriaController,
                decoration: const InputDecoration(
                  labelText: "Categoría",
                  hintText: "Ej: Electrónica",
                  prefixIcon: Icon(Icons.category_outlined),
                ),
                textCapitalization: TextCapitalization.words,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              final nombre = nombreController.text.trim();
              final precio = double.tryParse(precioController.text) ?? 0.0;
              final stock = int.tryParse(stockController.text) ?? 0;
              final categoria = categoriaController.text.trim();

              if (nombre.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('El nombre es obligatorio'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return;
              }

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
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }
}
