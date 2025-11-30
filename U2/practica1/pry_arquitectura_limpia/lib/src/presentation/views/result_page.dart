import 'package:flutter/material.dart';
import 'package:pry_arquitectura_limpia/src/domain/entities/operario.dart';
import 'package:pry_arquitectura_limpia/src/domain/entities/resultado_operario.dart';

class ResultPage extends StatelessWidget {
	final Operario operario;
	final ResultadoOperario resultado;

	const ResultPage({Key? key, required this.operario, required this.resultado}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Resultado')),
			body: Padding(
				padding: const EdgeInsets.all(16),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Text('Sueldo original: ${operario.sueldo.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
						const SizedBox(height: 8),
						Text('Antigüedad: ${operario.antiguedad} años', style: const TextStyle(fontSize: 18)),
						const Divider(height: 24),
						Text('Aumento: ${resultado.aumento.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
						const SizedBox(height: 8),
						Text('Sueldo final: ${resultado.sueldoFinal.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
						const SizedBox(height: 24),
						Center(
							child: ElevatedButton(
								onPressed: () => Navigator.of(context).pop(),
								child: const Text('Volver'),
							),
						),
					],
				),
			),
		);
	}
}