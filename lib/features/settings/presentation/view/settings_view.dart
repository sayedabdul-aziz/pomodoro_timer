import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro_timer/core/styles/app_color.dart';
import 'package:pomodoro_timer/core/utils/routers.dart';
import 'package:pomodoro_timer/features/pomodoro-timer/presentation/view-model/timer_cubit.dart';
import 'package:pomodoro_timer/features/pomodoro-timer/presentation/view-model/timer_state.dart';
import 'package:pomodoro_timer/features/settings/presentation/view/widgets/list_tile_item.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerCubit, TimerState>(builder: (context, state) {
      var cubit = BlocProvider.of<TimerCubit>(context);
      var focusCon = TextEditingController(text: cubit.focusTimer.toString());
      var shortCon = TextEditingController(text: cubit.shortTimer.toString());
      var longCon = TextEditingController(text: cubit.longTimer.toString());
      return Scaffold(
          backgroundColor: AppColors.focusBackgroundColor,
          appBar: AppBar(
            title: const Text('Settings'),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                height: 40,
                width: 40,
                child: FloatingActionButton(
                    heroTag: 'done',
                    foregroundColor: AppColors.focusTextColor,
                    backgroundColor: AppColors.focuslightColor,
                    elevation: 0.0,
                    child: const Icon(Icons.check),
                    onPressed: () {
                      cubit.setFocusTimer(int.parse(focusCon.text));
                      cubit.setShortTimer(int.parse(shortCon.text));
                      cubit.setLongTimer(int.parse(longCon.text));
                      GoRouter.of(context).pushReplacement(AppRouter.kPomodoro);
                    }),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ListTileItem(
                  text: 'Set Focus Timer',
                  cubit: cubit,
                  con: focusCon,
                ),
                const Gap(10),
                ListTileItem(
                  text: 'Set Short Break Timer',
                  cubit: cubit,
                  con: shortCon,
                ),
                const Gap(10),
                ListTileItem(
                  text: 'Set Long Break Timer',
                  cubit: cubit,
                  con: longCon,
                ),
              ],
            ),
          ));
    });
  }
}
