import 'package:flutter/material.dart';
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
                title: 'Word Lenght',
                value: wordLength,
                minValue: 4,
                maxValue: 7,
                onChanged: (value) {
                  setState(() {
                    wordLength = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
