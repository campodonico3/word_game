import 'package:flutter/material.dart';
import 'package:word_game/features/game/presentation/widgets/attempts_widget.dart';

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
        ],
      ),
    );
  }
}
