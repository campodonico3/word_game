import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:word_game/features/game/presentation/page/game_page.dart';
import 'package:word_game/features/home/widgets/slider_selection_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String route = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double wordLength = 4;
  double attemptsCount = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Guess It',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  letterSpacing: 2,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 32),
              SliderSelectionWidget(
                title: 'Word Lenght', // Tamaño de la palabra
                value: wordLength,
                minValue: 4,
                maxValue: 7,
                divisions: 3,
                onChanged: (value) {
                  setState(() {
                    wordLength = value;
                  });
                },
              ),
              SizedBox(height: 32),
              SliderSelectionWidget(
                title: 'Attempts Count', // Contador de intentos
                value: attemptsCount,
                minValue: 3,
                maxValue: 7,
                divisions: 4,
                onChanged: (value) {
                  setState(() {
                    attemptsCount = value;
                  });
                },
              ),
              Spacer(),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    context.push(
                      GamePage.route(
                        wordLength: wordLength.toInt(),
                        attemptsCount: attemptsCount.toInt(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 18),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.surface,
                    elevation: 5,
                    shadowColor: Colors.black.withOpacity(0.3),
                  ),
                  child: Text(
                    'Start Game',
                    style: Theme.of(context).textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
