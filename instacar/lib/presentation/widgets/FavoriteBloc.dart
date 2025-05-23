import 'package:flutter_bloc/flutter_bloc.dart';

// Eventos para o BLoC
abstract class FavoriteRideEvent {}

class ToggleFavorite extends FavoriteRideEvent {}

// Estado do BLoC
class FavoriteRideState {
  final bool isFavorited;
  FavoriteRideState(this.isFavorited);
}

// Implementação do BLoC
class FavoriteRideBloc extends Bloc<FavoriteRideEvent, FavoriteRideState> {
  FavoriteRideBloc() : super(FavoriteRideState(false)) {
    on<ToggleFavorite>((event, emit) {
      emit(FavoriteRideState(!state.isFavorited));
    });
  }
}
