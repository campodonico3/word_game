import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/features/game/presentation/bloc/game_event.dart';
import 'package:word_game/features/game/presentation/bloc/game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameState.initial()) {
    // Imprime el estado inicial al crear el Bloc
    debugPrint(
      '[GameBloc] GameBloc created. initial state -> '
      'status: ${state.status}, word: ${state.word}, attemptsCount: ${state.attemptsCount}',
    );

    on<StartGameEvent>(onStartGameEvent);
    on<EnterKeyEvent>(onEnterKeyEvent);
    on<DeletedKeyEvent>(onDeletedKeyEvent);
  }

  Future onStartGameEvent(StartGameEvent event, Emitter<GameState> emit) async {
    debugPrint(
      '[GameBloc] - StartGameEvent received -> attemptsCount: ${event.attemptsCount} - wordLength:${event.wordLength}',
    );
    debugPrint(
      '[GameBloc] - State BEFORE emit -> status: ${state.status}, word: ${state.word}, attemptsCount: ${state.attemptsCount}',
    );

    final newState = state.copyWith(
      status: GameStatus.inProgress,
      word: 'TEST',
      // currentAttempt: 'TGSS',
      // attempts: ['GETH'],
      attemptsCount: event.attemptsCount,
    );

    emit(newState);

    // Después del emit, state ya refleja newState
    debugPrint(
      '[GameBloc] - State AFTER emit -> status: ${state.status}, word: ${state.word}, attemptsCount: ${state.attemptsCount}',
    );
  }

  Future onEnterKeyEvent(EnterKeyEvent event, Emitter<GameState> emit) async {
    var currentAttempt = state.currentAttempt ?? '';
    var word = state.word ?? '';

    if (word.isEmpty) {
      return;
    }

    if (currentAttempt.length >= word.length) {
      return;
    }

    emit(state.copyWith(
      currentAttempt: currentAttempt + event.key,
      status: GameStatus.inProgress,
    ));
  }

  Future onDeletedKeyEvent(DeletedKeyEvent event, Emitter<GameState> emit) async {
    var currentAttempt = state.currentAttempt ?? '';
    if (currentAttempt.isEmpty) {
      return;
    }
    emit(state.copyWith(
      status: GameStatus.inProgress,
      currentAttempt: currentAttempt.substring(0, currentAttempt.length - 1),
    ));
  }
  
  @override
  void onEvent(GameEvent event) {
    super.onEvent(event);
    debugPrint('[GameBloc] - onEvent: ${event.runtimeType} -> $event');
  }

  /* @override
  void onChange(Change<GameState> change) {
    super.onChange(change);
    debugPrint('onChange: current=${change.current} -> next=${change.next}');
  } */
}
