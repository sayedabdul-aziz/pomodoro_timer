import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_timer/core/storage/local_storage.dart';
import 'package:pomodoro_timer/features/pomodoro-timer/presentation/view-model/timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(InitialState());

  Timer? _timer;
  int seconds = 1500; //initial focus Timer => 25 min = 1500 seconds,
  // users will set the time from settings view from focus, long and short break.

  late int focusTimer; //initial focus Timer => 25 min = 1500 seconds,
  late int shortTimer; //initial focus Timer => 5 min = 300 seconds,
  late int longTimer; // //initial focus Timer => 15 min = 900 seconds,

  int round = 1; // no of pomodoro rounds

  playing() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds--;
        emit(PlayingState());
      } else {
        // increase no of pomodoro rounds
        _timer?.cancel();
        round++;

        emit((InitialState()));
      }
    });
  }

  paused() {
    _timer?.cancel();
    emit(PausedState());
  }

  // when navigate to a new state we will use this setter

  setSeconds(int sec) {
    _timer?.cancel();
    seconds = sec;
    emit(InitialState());
  }

  setRound() {
    _timer?.cancel();
    round++;
    emit(InitialState());
  }

  // Setters and getters for all timers to edit them seconds and
  // cache the new timer to get it when restart our app.

  setFocusTimer(int sec) {
    focusTimer = sec;
    AppLocal.cacheData(AppLocal.focusTimer, sec);
    emit(InitialState());
  }

  setShortTimer(int sec) {
    shortTimer = sec;
    AppLocal.cacheData(AppLocal.shortTimer, sec);
    emit(InitialState());
  }

  setLongTimer(int sec) {
    longTimer = sec;
    AppLocal.cacheData(AppLocal.longTimer, sec);
    emit(InitialState());
  }

  // ---------- getters --------
  getFocusTimer() {
    AppLocal.getCachedData(AppLocal.focusTimer).then((value) {
      focusTimer = value ?? 1500;
      print(value);
      print(focusTimer);
      setSeconds(value ?? 1500);
    });

    emit(InitialState());
  }

  getShortTimer() {
    AppLocal.getCachedData(AppLocal.shortTimer).then((value) {
      shortTimer = value ?? 300;
      setSeconds(value ?? 300);
    });
    emit(InitialState());
  }

  getLongTimer() {
    AppLocal.getCachedData(AppLocal.longTimer).then((value) {
      longTimer = value ?? 900;
      setSeconds(value ?? 900);
    });
    emit(InitialState());
  }
}
