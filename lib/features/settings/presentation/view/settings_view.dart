import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pomodoro_timer/core/styles/app_color.dart';
import 'package:pomodoro_timer/features/pomodoro-timer/presentation/view-model/timer_cubit.dart';
import 'package:pomodoro_timer/features/pomodoro-timer/presentation/view-model/timer_state.dart';
import 'package:pomodoro_timer/features/settings/presentation/view/widgets/list_tile_item.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.focusBackgroundColor,
      appBar: AppBar(),
      body: BlocBuilder<TimerCubit, TimerState>(
        builder: (context, state) {
          var cubit = BlocProvider.of<TimerCubit>(context);
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ListTileItem(
                  text: 'Set Focus Timer',
                  cubit: cubit,
                  onChanged: (value) {
                    cubit.setFocusTimer(int.parse(value));
                  },
                  con: TextEditingController(text: cubit.focusTimer.toString()),
                ),
                const Gap(10),
                ListTileItem(
                  text: 'Set Short Break Timer',
                  cubit: cubit,
                  onChanged: (value) {
                    cubit.setShortTimer(int.parse(value));
                  },
                  con: TextEditingController(text: cubit.shortTimer.toString()),
                ),
                const Gap(10),
                ListTileItem(
                  text: 'Set Long Break Timer',
                  cubit: cubit,
                  onChanged: (value) {
                    cubit.setLongTimer(int.parse(value));
                  },
                  con: TextEditingController(text: cubit.longTimer.toString()),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
