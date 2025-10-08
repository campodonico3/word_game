import 'package:flutter/widgets.dart';
import 'package:word_game/features/game/presentation/widgets/attempt_row_widget.dart';

class AttemptsWidget extends StatelessWidget {
  const AttemptsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.7,
      child: ListView.separated(
        itemBuilder: (context, index) {
          debugPrint('Building item at index: $index');
          return AttemptRowWidget(attemptIndex: index);
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 10);
        },
        itemCount: 5,
      ),
    );
  }
}
