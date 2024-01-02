import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/styles/app_color.dart';
import 'package:pomodoro_timer/features/pomodoro-timer/presentation/view/widgets/body_content.dart';

class ShortBreakView extends StatelessWidget {
  const ShortBreakView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.shortBackgroundColor,
      body: BodyContentWidget(
          status: 'Short Break',
          icon: Icons.coffee_rounded,
          textColor: AppColors.shortTextColor,
          lightColor: AppColors.shortlightColor,
          primaryColor: AppColors.shortPrimaryColor),
    );
  }
}
