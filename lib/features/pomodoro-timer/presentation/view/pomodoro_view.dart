import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/styles/app_color.dart';
import 'package:pomodoro_timer/features/pomodoro-timer/presentation/view/widgets/body_content.dart';

class PomodoroView extends StatelessWidget {
  const PomodoroView({super.key});

  @override
  Widget build(BuildContext context) {
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
