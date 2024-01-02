import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_timer/core/styles/app_color.dart';
import 'package:pomodoro_timer/features/pomodoro-timer/presentation/view-model/timer_cubit.dart';
import 'package:pomodoro_timer/features/pomodoro-timer/presentation/view/widgets/body_content.dart';

class PomodoroView extends StatelessWidget {
  const PomodoroView({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<TimerCubit>();
    cubit.setSeconds(cubit.focusTimer);
    return Scaffold(
      backgroundColor: AppColors.focusBackgroundColor,
      body: BodyContentWidget(
          status: 'Focus',
          icon: Icons.flourescent_sharp,
          textColor: AppColors.focusTextColor,
          lightColor: AppColors.focuslightColor,
          primaryColor: AppColors.focusPrimaryColor),
    );
  }
}
