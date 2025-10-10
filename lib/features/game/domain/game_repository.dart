import 'package:word_game/core/failure/failure.dart';
import 'package:word_game/core/models/either.dart';

abstract class GameRepository {
  Future<Either<Failure, String>> getRandomWord(int length);
  Future<Either<Failure, void>> checkWord(String word);
}