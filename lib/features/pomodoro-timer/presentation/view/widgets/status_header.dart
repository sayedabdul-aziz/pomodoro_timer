import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pomodoro_timer/core/styles/app_color.dart';

class StatusHeaderWidget extends StatelessWidget {
  const StatusHeaderWidget({
    super.key,
    required this.lightColor,
    required this.icon,
    required this.status,
  });

  final Color lightColor;
  final IconData icon;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: lightColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.focusTextColor)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const Gap(5),
          Text(status),
        ],
      ),
    );
  }
}
