import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/styles/app_color.dart';
import 'package:pomodoro_timer/features/pomodoro-timer/presentation/view/widgets/body_content.dart';

class LongBreakView extends StatelessWidget {
  const LongBreakView({super.key});

  @override
  Widget build(BuildContext context) {
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
