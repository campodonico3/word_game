import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/features/game/presentation/bloc/game_bloc.dart';
import 'package:word_game/features/game/presentation/bloc/game_state.dart';
import 'package:word_game/features/game/presentation/widgets/attempt_row_widget.dart';

class AttemptsWidget extends StatelessWidget {
  const AttemptsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        debugPrint('[AttemptsWidget] - El valor de attemptsCount es : ${state.attemptsCount}');
        return Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 700,
            child: ListView.separated(
              itemBuilder: (context, index) {
                // debugPrint('Building item at index: $index');
                return AttemptRowWidget(attemptIndex: index);
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemCount: state.attemptsCount ?? 5,
            ),  
          ),
        );
      },
    );
  }
}
