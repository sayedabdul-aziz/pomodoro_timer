import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_timer/core/styles/app_color.dart';
import 'package:pomodoro_timer/features/pomodoro-timer/presentation/view-model/timer_cubit.dart';
import 'package:pomodoro_timer/features/pomodoro-timer/presentation/view/widgets/body_content.dart';

class LongBreakView extends StatelessWidget {
  const LongBreakView({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<TimerCubit>();
    cubit.setSeconds(cubit.longTimer);
    return Scaffold(
      backgroundColor: AppColors.longBackgroundColor,
      body: BodyContentWidget(
          status: 'Long Break',
          icon: Icons.coffee_rounded,
          textColor: AppColors.longTextColor,
          lightColor: AppColors.longlightColor,
          primaryColor: AppColors.longPrimaryColor),
    );
  }
}
