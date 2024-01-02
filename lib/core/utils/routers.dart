import 'package:go_router/go_router.dart';
import 'package:pomodoro_timer/features/pomodoro-timer/presentation/view/long_break_view.dart';
import 'package:pomodoro_timer/features/pomodoro-timer/presentation/view/pomodoro_view.dart';
import 'package:pomodoro_timer/features/pomodoro-timer/presentation/view/short_break_view.dart';
import 'package:pomodoro_timer/features/settings/presentation/view/settings_view.dart';

abstract class AppRouter {
  static const kPomodoro = '/';
  static const kLongBreak = '/long';
  static const kShortBreak = '/short';
  static const kSettings = '/settings';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: kPomodoro,
        builder: (context, state) => const PomodoroView(),
      ),
      GoRoute(
        path: kShortBreak,
        builder: (context, state) => const ShortBreakView(),
      ),
      GoRoute(
        path: kLongBreak,
        builder: (context, state) => const LongBreakView(),
      ),
      GoRoute(
        path: kSettings,
        builder: (context, state) => const SettingsView(),
      ),
    ],
  );
}
