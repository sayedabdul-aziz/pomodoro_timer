import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro_timer/configuration/size_configuration.dart';
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
    double height = SizeConfiguration.screenHeight!;
    var textStyle = (status != 'Focus')
        ? getLightStyle(
            fontSize: height * .168,
            color: textColor,
          ).copyWith(
            height: 0,
          )
        : getBoldStyle(
            fontSize: height * .168,
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
                    elevation: 0.0,
                    child: const Icon(Icons.more_horiz_rounded),
                    onPressed: () {
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
                            elevation: 0.0,
                            child: const Icon(Icons.pause),
                            onPressed: () => cubit.paused())
                        : FloatingActionButton(
                            heroTag: 'play',
                            backgroundColor: primaryColor,
                            elevation: 0.0,
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
                    elevation: 0.0,
                    child: const Icon(Icons.skip_next_rounded),
                    onPressed: () {
                      cubit.restart();
                      //Two short breaks and then a long break, for ex.
                      // Focus > Short break > Focus > Short break > Focus > Long break > Focus >... etc.
                      if (status != 'Focus') {
                        GoRouter.of(context).push(AppRouter.kPomodoro);
                      } else if (cubit.round % 3 == 0 && cubit.round != 0) {
                        // set long break timer by 15 min = 900 seconds
                        cubit.setSeconds(cubit.longTimer);
                        GoRouter.of(context).push(AppRouter.kLongBreak);
                      } else {
                        // set short break timer by 5 min = 300 seconds
                        cubit.setSeconds(cubit.shortTimer);
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
