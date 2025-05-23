import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instacar/core/models/RideCard.dart';

void main() {
  testWidgets('deve mostrar favoritar e alternar ícone ao clicar', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RideCard(
            name: 'João',
            genderAge: 'M, 30',
            date: '22/05/2025',
            from: 'São Paulo',
            to: 'Rio de Janeiro',
            type: 'Carro',
            model: 'Civic',
            color: 'Preto',
            plate: 'XYZ-1234',
            totalSpots: 4,
            takenSpots: 2,
            observation: 'Levo bagagem',
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.favorite_border), findsOneWidget);

    await tester.tap(find.text('Favoritar'));
    await tester.pump(); // rebuild após clique

    expect(find.byIcon(Icons.favorite), findsOneWidget);

    await tester.tap(find.text('Favoritar'));
    await tester.pump();

    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
  });
}
