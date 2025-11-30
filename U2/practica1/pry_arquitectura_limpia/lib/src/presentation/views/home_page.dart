import 'package:flutter/material.dart';
import 'package:pry_arquitectura_limpia/src/domain/entities/operario.dart';
import 'package:pry_arquitectura_limpia/src/domain/usecases/calcular_aumento.dart';
import 'package:pry_arquitectura_limpia/src/presentation/views/result_page.dart';

class HomePage extends StatefulWidget {
	const HomePage({Key? key}) : super(key: key);

	@override
	State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
	final _sueldoCtrl = TextEditingController();
	final _antigCtrl = TextEditingController();
	int _antig = 0;
	double _antigSlider = 0;
	int? _radioAnt = null;

	@override
	void dispose() {
		_sueldoCtrl.dispose();
		_antigCtrl.dispose();
		super.dispose();
	}

	void _setAntig(int value) {
		setState(() {
			_antig = value;
			_antigSlider = value.toDouble();
			_antigCtrl.text = value.toString();
			_radioAnt = (value == 0 || value == 5 || value == 10 || value == 15) ? value : null;
		});
	}

  

	void _calcular() {
		final sueldo = double.tryParse(_sueldoCtrl.text.replaceAll(',', '.'));
		final antig = int.tryParse(_antigCtrl.text) ?? _antig;
		if (sueldo == null) {
			ScaffoldMessenger.of(context).showSnackBar(
				const SnackBar(content: Text('Ingrese sueldo y antigüedad válidos')),
			);
			return;
		}

		final operario = Operario(sueldo: sueldo, antiguedad: antig);
		final resultado = CalcularAumentoUseCases().ejecutar(operario);

		Navigator.of(context).push(
			MaterialPageRoute(
				builder: (_) => ResultPage(operario: operario, resultado: resultado),
			),
		);
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Calculadora de Aumento')),
			body: SingleChildScrollView(
				padding: const EdgeInsets.all(16),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						TextFormField(
							controller: _sueldoCtrl,
							keyboardType:
									const TextInputType.numberWithOptions(decimal: true),
							decoration: const InputDecoration(
								labelText: 'Sueldo',
								hintText: 'Ej. 450.50',
							),
						),
						const SizedBox(height: 12),
						TextFormField(
							controller: _antigCtrl,
							keyboardType: TextInputType.number,
							decoration: const InputDecoration(
								labelText: 'Antigüedad (años)',
								hintText: 'Ej. 5',
							),
							onChanged: (v) {
								final parsed = int.tryParse(v);
								if (parsed != null) {
									setState(() {
										_antig = parsed;
										_antigSlider = parsed.toDouble();
										// if matches common radio values, set it
										if (parsed == 0 || parsed == 5 || parsed == 10 || parsed == 15) {
											_radioAnt = parsed;
										} else {
											_radioAnt = null;
										}
									});
								}
							},
						),
						const SizedBox(height: 20),
						const Text('Elegir antigüedad (slider o opciones)', style: TextStyle(fontSize: 16)),
						Slider(
							min: 0,
							max: 40,
							divisions: 40,
							label: _antigSlider.round().toString(),
							value: _antigSlider,
							onChanged: (v) => _setAntig(v.round()),
						),
						RadioListTile<int>(value: 0, groupValue: _radioAnt, title: const Text('0 años'), onChanged: (v) => _setAntig(v ?? 0)),
						RadioListTile<int>(value: 5, groupValue: _radioAnt, title: const Text('5 años'), onChanged: (v) => _setAntig(v ?? 0)),
						RadioListTile<int>(value: 10, groupValue: _radioAnt, title: const Text('10 años'), onChanged: (v) => _setAntig(v ?? 0)),
						RadioListTile<int>(value: 15, groupValue: _radioAnt, title: const Text('15 años'), onChanged: (v) => _setAntig(v ?? 0)),
						const SizedBox(height: 20),
						Center(
							child: ElevatedButton(
								onPressed: _calcular,
								child: const Text('Calcular'),
							),
						),
					],
				),
			),
		);
	}
}