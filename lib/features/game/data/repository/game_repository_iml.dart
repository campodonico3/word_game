import 'package:dio/dio.dart';
import 'package:word_game/core/failure/failure.dart';
import 'package:word_game/core/models/either.dart';
import 'package:word_game/features/game/data/datasource/game_remote_datasource.dart';
import 'package:word_game/features/game/domain/game_repository.dart';

class GameRepositoryIml implements GameRepository {
  final GameRemoteDatasource gameRemoteDatasource;

  GameRepositoryIml({required this.gameRemoteDatasource});

  @override
  Future<Either<Failure, void>> checkWord(String word) async{
    try {
      // ignore: unused_local_variable
      var result = await gameRemoteDatasource.checkWord(word);
      return Right(null);
    } on DioException catch (e){
      return Left(GameFailure(message: 'Please, enter correct word $e'));
    } 
    catch (e) {
      return Left(GameFailure(message: 'Please, enter correct word'));
    }
  }

  @override
  Future<Either<Failure, String>> getRandomWord(int length) async {
    try {
      var result = await gameRemoteDatasource.getRandomWord(length);
      try {
        await gameRemoteDatasource.checkWord(result);
      } catch (e) {
        return getRandomWord(length);
      }
      return Right(result);
    }catch (e) {
      return Left(GameFailure(message: 'Error'));
    }
  }
}
