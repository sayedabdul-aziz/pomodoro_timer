import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro_timer/core/functions/handle_time.dart';
import 'package:pomodoro_timer/core/styles/app_color.dart';
import 'package:pomodoro_timer/core/styles/styles_manager.dart';
import 'package:pomodoro_timer/core/utils/routers.dart';
import 'package:pomodoro_timer/features/pomodoro-timer/presentation/view-model/pomodoro_cubit.dart';
import 'package:pomodoro_timer/features/pomodoro-timer/presentation/view-model/pomodoro_state.dart';
import 'package:pomodoro_timer/features/pomodoro-timer/presentation/view/widgets/status_header.dart';

class BodyContentWidget extends StatelessWidget {
  const BodyContentWidget({
    super.key,
    required this.status,
    required this.textColor,
    required this.lightColor,
    required this.primaryColor,
    required this.icon,
  });

  final String status;
  final Color textColor;
  final IconData icon;
  final Color lightColor;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    var textStyle = getBoldStyle(fontSize: 90, color: AppColors.focusTextColor)
        .copyWith(height: 0);
    var cubit = BlocProvider.of<TimerCubit>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ---------- header ----------------------
          StatusHeaderWidget(
              lightColor: lightColor, icon: icon, status: status),
          const Gap(20),

          // ----------- Timer ---------------------
          BlocBuilder<TimerCubit, TimerState>(
            builder: (context, state) {
              var time = formatDuration(cubit.seconds);
              return Column(
                children: [
                  Text(
                    time[0].toString(),
                    style: textStyle,
                  ),
                  Text(
                    time[1].toString(),
                    style: textStyle,
                  ),
                ],
              );
            },
          ),
          const Gap(20),

          // ----------- Control Btns -------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                child: FloatingActionButton(
                    backgroundColor: lightColor,
                    elevation: 0.0,
                    child: const Icon(Icons.more_vert_rounded),
                    onPressed: () {}),
              ),
              const Gap(10),
              SizedBox(
                width: 80,
                height: 60,
                child: BlocBuilder<TimerCubit, TimerState>(
                  builder: (context, state) {
                    // Users can pause the timer at any time as well as jump to the next state.
                    return (state is PlayingState)
                        ? FloatingActionButton(
                            backgroundColor: primaryColor,
                            elevation: 0.0,
                            child: const Icon(Icons.pause),
                            onPressed: () => cubit.paused())
                        : FloatingActionButton(
                            backgroundColor: primaryColor,
                            elevation: 0.0,
                            child: const Icon(Icons.play_arrow),
                            onPressed: () => cubit.playing());
                  },
                ),
              ),
              const Gap(10),
              SizedBox(
                height: 50,
                child: FloatingActionButton(
                    backgroundColor: lightColor,
                    elevation: 0.0,
                    child: const Icon(Icons.skip_next_rounded),
                    onPressed: () {
                      //Two short breaks and then a long break, for ex.
                      // Focus > Short break > Focus > Short break > Focus > Long break > Focus >... etc.
                      if (status != 'Focus') {
                        GoRouter.of(context).push(AppRouter.kPomodoro);
                      } else if (cubit.round % 3 == 0 && cubit.round != 0) {
                        GoRouter.of(context).push(AppRouter.kLongBreak);
                      } else {
                        GoRouter.of(context).push(AppRouter.kShortBreak);
                      }
                    }),
              ),
            ],
          )
        ],
      ),
    );
  }
}
