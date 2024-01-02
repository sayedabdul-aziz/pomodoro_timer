import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_timer/configuration/size_configuration.dart';
import 'package:pomodoro_timer/core/styles/theme_manager.dart';
import 'package:pomodoro_timer/core/utils/routers.dart';
import 'package:pomodoro_timer/features/pomodoro-timer/presentation/view-model/timer_cubit.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfiguration.init(context);
    return BlocProvider(
      create: (context) => TimerCubit()
        ..getFocusTimer()
        ..getLongTimer()
        ..getShortTimer(),
      child: MaterialApp.router(
        theme: getAppTheme(),
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
