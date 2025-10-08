enum GameStatus { initial, loading, inProgress, win, loss, error }

class GameState {
  final GameStatus status;
  final String? errorMessage;

  final List<String>? attempts;
  final String? currentAttempt;

  final String? word;
  final int? attemptsCount;

  GameState._({
    required this.status,
    this.errorMessage,
    this.attempts,
    this.currentAttempt,
    this.word,
    this.attemptsCount,
  });

  factory GameState.initial() => GameState._(status: GameStatus.initial);

  GameState copyWith({
    GameStatus? status,
    String? errorMessage,
    List<String>? attempts,
    String? currentAttempt,
    String? word,
    int? attemptsCount,
  }) => GameState._(
    status: status ?? this.status,
    errorMessage:  errorMessage ?? this.errorMessage,
    attempts: attempts ?? this.attempts,
    currentAttempt: currentAttempt ?? this.currentAttempt,
    word: word ?? this.word,
    attemptsCount: attemptsCount ?? this.attemptsCount,
  );
}
