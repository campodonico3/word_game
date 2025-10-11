import 'package:get_it/get_it.dart';
import 'package:word_game/features/game/presentation/bloc/game_bloc.dart';

var getIt = GetIt.instance;

void setup() {
  registerBloc();
}

void registerRepositories() {
  // TODO
}

void registerBloc() {
  getIt.registerFactory<GameBloc>(() => GameBloc(gameRepository: getIt()));
}