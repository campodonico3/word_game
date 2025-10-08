import 'package:flutter/material.dart';

class AttemptRowWidget extends StatelessWidget {
  final int attemptIndex;
  const AttemptRowWidget({super.key, required this.attemptIndex});

  @override
  Widget build(BuildContext context) {
    final word = 'TEST';

    return
    //final word = state.word ?? '';
    //final previousAttempts = state.attempts ?? [];
    //final currentAttempt = state.currentAttempt ?? '';
    //final isCurrentAttempt = attemptIndex == previousAttempts.length;
    Row(
      children: List.generate(word.length, (letterIndex) {
        return Expanded(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(color: Colors.amber),
          ),
        );
      }),
    );
  }
}
