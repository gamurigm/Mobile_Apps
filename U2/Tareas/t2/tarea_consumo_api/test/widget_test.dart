// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:consumo_apis2/main.dart';
import 'package:consumo_apis2/domain/usecases/getproductos_usecase.dart';
import 'package:consumo_apis2/data/repositories/base_repository.dart';
import 'package:consumo_apis2/domain/entities/producto_entity.dart';

// A tiny fake repository for tests that returns an empty ProductoEntity list.
class _FakeRepo implements BaseRepository {
  @override
  Future<List<ProductoEntity>> getProductos() async => <ProductoEntity>[];
}

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame. Provide a simple usecase backed by a fake repo.
    final usecase = GetProductosUseCase(_FakeRepo());
    await tester.pumpWidget(MyApp(usecase: usecase));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
