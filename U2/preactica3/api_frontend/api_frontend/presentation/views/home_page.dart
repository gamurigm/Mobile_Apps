import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/producto_viewmodel.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProductoViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Productos")),
      body: vm.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: vm.productos.length,
        itemBuilder: (_, i) {
          final p = vm.productos[i];
          return ListTile(
            title: Text(p.nombre),
            subtitle: Text("Precio: \$${p.precio}"),
          );
        },
      ),
    );
  }
}
