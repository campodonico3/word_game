import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/core/theme/app_colors.dart';
import 'package:word_game/features/game/presentation/bloc/game_bloc.dart';
import 'package:word_game/features/game/presentation/bloc/game_state.dart';
import 'package:word_game/features/game/presentation/widgets/letter_box_widget.dart';

class AttemptRowWidget extends StatelessWidget {
  final int attemptIndex; // Índice que identifica qué fila de intento representa (0, 1, 2, 3, 4, 5...)
  const AttemptRowWidget({super.key, required this.attemptIndex});

  @override
  Widget build(BuildContext context) {
    //final word = 'TEST'; //
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        final word = state.word ?? ''; // La palabra correcta a adivinar 
        final previousAttempts = state.attempts ?? []; // Lista de intentos ya completados
        final currentAttempt = state.currentAttempt ?? ''; // El intento que el usuario está escribiendo actualmente
        final isCurrentAttempt = attemptIndex == previousAttempts.length; // Verifica si esta fila es el intento actual

        debugPrint('[AttemptRowWidget] - word: $word');
        debugPrint('[AttemptRowWidget] - previousAttempts: $previousAttempts');
        debugPrint('[AttemptRowWidget] - currentAttempt: $currentAttempt');
        debugPrint('[AttemptRowWidget] - isCurrentAttempt: $isCurrentAttempt');

        return Row(
          children: List.generate(word.length, (letterIndex) {
            var text = _getLetter(
              letterIndex,
              attemptIndex,
              previousAttempts,
              currentAttempt,
              isCurrentAttempt,
            );

            var boxColor = _getBoxColor(
              context,
              text,
              word,
              attemptIndex,
              letterIndex,
              previousAttempts,
              isCurrentAttempt,
            );

            var textColor = _getTextColor(
              context,
              text,
              word,
              attemptIndex,
              letterIndex,
              previousAttempts,
              isCurrentAttempt,
            );

            return Expanded(
              child: LetterBoxWidget(
                text: text,
                boxColor: boxColor,
                textColor: textColor,
              ),
            );
          }),
        );
      },
    );
  }

  String _getLetter(
    int letterIndex,
    int attemptIndex,
    List<String> previousAttempts,
    String currentAttempt,
    bool isCurrentAttempt,
  ) {
    // Si es un intento anterior: Devuelve la letra del intento guardado
    // Si es el intento actual: Devuelve la letra si existe en la posición, sino string vacío
    // Si es un intento futuro: Devuelve string vacío
    if (attemptIndex < previousAttempts.length) {
      return previousAttempts[attemptIndex][letterIndex];
    } else if (isCurrentAttempt) {
      return letterIndex < currentAttempt.length
          ? currentAttempt[letterIndex]
          : '';
    }
    return '';
  }

  Color? _getBoxColor(
    BuildContext context,
    String letter,
    String word,
    int attemptIndex,
    int letterIndex,
    List<String> previousAttempts,
    bool isCurrentAttempt,
  ) {
    // Si es intento futuro, vacío o actual: Sin color (null)
    // Si la letra está en la posición correcta: Verde
    // Si la letra existe pero en otra posición: Amarillo
    // Si la letra no existe en la palabra: Gris (onSurfaceVariant)
    if (attemptIndex >= previousAttempts.length ||
        letter.isEmpty ||
        isCurrentAttempt) {
      return null;
    } else if (word[letterIndex] == letter) {
      return AppColors.green;
    } else if (word.contains(letter)) {
      return AppColors.yellow;
    }
    return Theme.of(context).colorScheme.onSurfaceVariant;
  }

  Color? _getTextColor(
    BuildContext context,
    String letter,
    String word,
    int attemptIndex,
    int letterIndex,
    List<String> previousAttempts,
    bool isCurrentAttempt,
  ) {
    if (attemptIndex >= previousAttempts.length ||
        letter.isEmpty ||
        isCurrentAttempt) {
      return Theme.of(context).colorScheme.onSurface;
    } else if (word[letterIndex] == letter || word.contains(letter)) {
      return Theme.of(context).colorScheme.onSurface;
    }
    return Theme.of(context).colorScheme.onSurface;
  }
}
