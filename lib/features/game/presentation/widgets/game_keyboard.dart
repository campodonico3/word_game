import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/core/theme/app_colors.dart';
import 'package:word_game/features/game/presentation/bloc/game_bloc.dart';
import 'package:word_game/features/game/presentation/bloc/game_state.dart';

class GameKeyboard extends StatelessWidget {
  final Function(String) onKeyPressed;
  // Función que recibe un String como parámetro
  // Se ejecuta cuando el usuario presiona una tecla de letra
  // Ejemplo: onKeyPressed('A') cuando presionan la tecla A
  final Function() onDelete; // Se ejecuta para borrar la última letra
  final Function() onSubmit; // Se ejecuta para enviar el intento completo

  const GameKeyboard({
    super.key,
    required this.onKeyPressed,
    required this.onDelete,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    const rows = ['QWERTYUIOP', 'ASDFGHJKLÑ', 'ZXCVBNM'];
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /* 
                -> rows.map(...): Transforma cada string en un Widget
                -> ... (spread operator): "Desempaqueta" la lista resultante
                -> Sin ...: Tendrías [Widget1, Widget2, Widget3] (lista dentro de lista)
                -> Con ...: Tienes Widget1, Widget2, Widget3 (widgets individuales)
                -> Equivalente sin spread:
                    children: [
                      _buildKeyBoardRow(context, state, 'QWERTYUIOP'),
                      _buildKeyBoardRow(context, state, 'ASDFGHJKLÑ'),
                      _buildKeyBoardRow(context, state, 'ZXCVBNM'),
                    ]
              */
              ...rows.map((row) => _buildKeyBoardRow(context, state, row)),
              SizedBox(height: 2),
              _buildActionRow(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildKeyBoardRow(BuildContext context, GameState state, String row) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          // 'QWERTY'.split('') -> Resultado: ['Q', 'W', 'E', 'R', 'T', 'Y']
          // -> Transforma cada letra en un Widget de tecla
          // -> .toList(): Convierte el resultado de map (un Iterable) en una Lista
          row.split('').map((key) => _buildKey(context, state, key)).toList(),
    );
  }

  Widget _buildActionRow(BuildContext context, GameState state) {
    var currentAttempt = state.currentAttempt ?? '';
    var word = state.word ?? '';

    return Row(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 3,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: ElevatedButton(
                onPressed: () {
                  onDelete();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Icon(Icons.backspace, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: AspectRatio(
            aspectRatio: 3,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: ElevatedButton(
                onPressed: currentAttempt.length < word.length
                    ? null
                    : () => onSubmit(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Enter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKey(BuildContext context, GameState state, String key) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 0.8,
        child: Padding(
          padding: EdgeInsets.all(3),
          child: ElevatedButton(
            onPressed: () => onKeyPressed(key),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              key,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
