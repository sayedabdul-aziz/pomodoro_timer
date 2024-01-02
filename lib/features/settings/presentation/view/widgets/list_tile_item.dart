import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomodoro_timer/core/styles/app_color.dart';
import 'package:pomodoro_timer/core/styles/styles_manager.dart';
import 'package:pomodoro_timer/features/pomodoro-timer/presentation/view-model/timer_cubit.dart';

class ListTileItem extends StatelessWidget {
  const ListTileItem({
    super.key,
    required this.cubit,
    required this.text,
    required this.onChanged,
    required this.con,
  });

  final TimerCubit cubit;
  final String text;
  final Function(String)? onChanged;
  final TextEditingController con;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        tileColor: AppColors.focuslightColor,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          text,
          style:
              getSemiBoldStyle(fontSize: 18, color: AppColors.focusTextColor),
        ),
        trailing: SizedBox(
            width: 80,
            child: TextFormField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: onChanged,
              controller: con,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(suffix: Text('Sec')),
            )));
  }
}
