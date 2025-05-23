import 'package:flutter_test/flutter_test.dart';
import '../lib/presentation/widgets/FavoriteBloc.dart';

void main() {
  late FavoriteRideBloc bloc;

  setUp(() {
    bloc = FavoriteRideBloc();
  });

  tearDown(() {
    bloc.close();
  });

  test('estado inicial deve ser não favoritado (false)', () {
    expect(bloc.state.isFavorited, false);
  });

  test('ao disparar ToggleFavorite, estado inverte para true', () async {
    bloc.add(ToggleFavorite());

    await expectLater(
      bloc.stream,
      emitsInOrder([
        FavoriteRideState(true),
      ]),
    );
  });

  test('duas vezes ToggleFavorite volta para false', () async {
    bloc.add(ToggleFavorite());
    bloc.add(ToggleFavorite());

    await expectLater(
      bloc.stream,
      emitsInOrder([
        FavoriteRideState(true),
        FavoriteRideState(false),
      ]),
    );
  });
}
