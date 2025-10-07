abstract class GameEvent {}

class StartGameEvent extends GameEvent {
  final int wordLength;
  final int attemptsCount;

  StartGameEvent({required this.wordLength, required this.attemptsCount});
}

class EnterAttemptEvent extends GameEvent {}

class EnterKeyEvent extends GameEvent {
  final String key;

  EnterKeyEvent({required this.key});
}

class DeletedKeyEvent extends GameEvent {}
