import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/core/get_it/get_it.dart';
import 'package:word_game/features/game/presentation/bloc/game_bloc.dart';
import 'package:word_game/features/game/presentation/bloc/game_event.dart';
import 'package:word_game/features/game/presentation/bloc/game_state.dart';
import 'package:word_game/features/game/presentation/widgets/attempts_widget.dart';
import 'package:word_game/features/game/presentation/widgets/game_keyboard.dart';

class GamePage extends StatelessWidget {
  final int wordLength;
  final int attemptsCount;

  const GamePage({
    super.key,
    required this.wordLength,
    required this.attemptsCount,
  });

  static String route({required int wordLength, required int attemptsCount}) =>
      Uri(
        path: '/game',
        queryParameters: {
          'wordLength': wordLength.toString(),
          'attemptsCount': attemptsCount.toString(),
        },
      ).toString();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GameBloc>()
        ..add(
          StartGameEvent(attemptsCount: attemptsCount, wordLength: wordLength),
        ),
      child: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Game',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            body: Column(
              children: [
                SizedBox(height: 20),
                Expanded(child: AttemptsWidget()),
                //Spacer(),
                GameKeyboard(
                  onKeyPressed: (v) {
                    context.read<GameBloc>().add(EnterKeyEvent(key: v));
                  },
                  onDelete: () {
                    context.read<GameBloc>().add(DeletedKeyEvent());
                  },
                  onSubmit: () {
                    context.read<GameBloc>().add(EnterAttemptEvent());
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
