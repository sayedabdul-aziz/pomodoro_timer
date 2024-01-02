import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro_timer/core/functions/handle_time.dart';
import 'package:pomodoro_timer/core/styles/styles_manager.dart';
import 'package:pomodoro_timer/core/utils/routers.dart';
import 'package:pomodoro_timer/features/pomodoro-timer/presentation/view-model/timer_cubit.dart';
import 'package:pomodoro_timer/features/pomodoro-timer/presentation/view-model/timer_state.dart';
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
    var textStyle = (status != 'Focus')
        ? getLightStyle(
            fontSize: 120,
            color: textColor,
          ).copyWith(
            height: 0,
          )
        : getBoldStyle(
            fontSize: 120,
            color: textColor,
          ).copyWith(
            height: 0,
          );
    var cubit = BlocProvider.of<TimerCubit>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ---------- header ----------------------
          StatusHeaderWidget(
              textColor: textColor,
              lightColor: lightColor,
              icon: icon,
              status: status),
          const Gap(10),

          // ----------- Timer ---------------------
          BlocBuilder<TimerCubit, TimerState>(
            builder: (context, state) {
              var time = formatDuration(cubit.seconds);

              return Column(
                children: [
                  // min Text
                  SizedBox(
                    height: 120,
                    child: Text(
                      time[0].toString(),
                      style: textStyle,
                    ),
                  ),

                  // sec Text
                  SizedBox(
                    height: 120,
                    child: Text(
                      time[1].toString(),
                      style: textStyle,
                    ),
                  ),
                ],
              );
            },
          ),
          const Gap(30),

          // ----------- Control Btns -------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ------- Go to settings -----------
              SizedBox(
                height: 40,
                width: 40,
                child: FloatingActionButton(
                    heroTag: 'settings',
                    backgroundColor: lightColor,
                    foregroundColor: textColor,
                    child: const Icon(Icons.more_horiz_rounded),
                    onPressed: () {
                      cubit.paused();
                      GoRouter.of(context).push(AppRouter.kSettings);
                    }),
              ),
              const Gap(10),

              // ------- play & pause -----------
              SizedBox(
                width: 70,
                height: 50,
                child: BlocBuilder<TimerCubit, TimerState>(
                  builder: (context, state) {
                    // Users can pause the timer at any time as well as jump to the next state.
                    return (state is PlayingState)
                        ? FloatingActionButton(
                            heroTag: 'pause',
                            backgroundColor: primaryColor,
                            foregroundColor: textColor,
                            child: const Icon(Icons.pause),
                            onPressed: () => cubit.paused())
                        : FloatingActionButton(
                            heroTag: 'play',
                            backgroundColor: primaryColor,
                            foregroundColor: textColor,
                            child: const Icon(Icons.play_arrow),
                            onPressed: () => cubit.playing());
                  },
                ),
              ),
              const Gap(10),

              // ------- Go to next state -----------
              SizedBox(
                height: 40,
                width: 40,
                child: FloatingActionButton(
                    heroTag: 'next state',
                    backgroundColor: lightColor,
                    foregroundColor: textColor,
                    child: const Icon(Icons.fast_forward),
                    onPressed: () {
                      //Two short breaks and then a long break, for ex.
                      // Focus > Short break > Focus > Short break > Focus > Long break > Focus >... etc.
                      if (status != 'Focus') {
                        GoRouter.of(context)
                            .pushReplacement(AppRouter.kPomodoro);
                      } else if (cubit.round % 3 == 0 && cubit.round != 0) {
                        cubit.setRound();

                        GoRouter.of(context)
                            .pushReplacement(AppRouter.kLongBreak);
                      } else {
                        cubit.setRound();

                        GoRouter.of(context)
                            .pushReplacement(AppRouter.kShortBreak);
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
