import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import '../lib/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Fluxo favoritar e desfavoritar carona', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final favoritarButton = find.text('Favoritar');

    expect(favoritarButton, findsOneWidget);

    await tester.tap(favoritarButton);
    await tester.pumpAndSettle();

    expect(find.textContaining('Carona Favoritada'), findsOneWidget);

    await tester.tap(favoritarButton);
    await tester.pumpAndSettle();

    expect(find.textContaining('Carona Desfavoritada'), findsOneWidget);
  });
}
