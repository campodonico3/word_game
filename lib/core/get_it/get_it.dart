import 'package:get_it/get_it.dart';
import 'package:word_game/core/api/dio_client.dart';
import 'package:word_game/features/game/data/datasource/game_remote_datasource.dart';
import 'package:word_game/features/game/data/repository/game_repository_iml.dart';
import 'package:word_game/features/game/domain/game_repository.dart';
import 'package:word_game/features/game/presentation/bloc/game_bloc.dart';

var getIt = GetIt.instance;

void setup() {
  registerDatasources();
  registerRepositories();
  registerBloc();
}

void registerDatasources(){
  getIt.registerSingleton(GameRemoteDatasource(dio: DioClient.getDio()));
}

void registerRepositories() {
  getIt.registerSingleton<GameRepository>(GameRepositoryIml(gameRemoteDatasource: getIt()));
}

void registerBloc() {
  getIt.registerFactory<GameBloc>(() => GameBloc(gameRepository: getIt()));
}