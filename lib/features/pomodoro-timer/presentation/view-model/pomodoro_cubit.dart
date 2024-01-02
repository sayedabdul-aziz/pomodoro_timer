import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_timer/features/pomodoro-timer/presentation/view-model/pomodoro_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(InitialState());

  Timer? _timer;
  int seconds = 1500;

  int round = 0;

  playing() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds--;
        emit(PlayingState());
      } else {
        round++;
        _timer?.cancel();
        emit((InitialState()));
      }
    });
  }

  paused() {
    _timer?.cancel();
    emit(PausedState());
  }

  restart() {
    _timer?.cancel();
    seconds = 1500;
    emit(InitialState());
  }
}
