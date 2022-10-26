import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/button.dart';
import '../icons/my_flutter_app_icons.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({
    Key? key,
    required this.hours,
    required this.minutes,
    required this.seconds,
  }) : super(key: key);
  final int hours;
  final int minutes;
  final int seconds;

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage>
    with TickerProviderStateMixin {
  late AnimationController controller;

  bool isPlaying = true;

  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${(controller.duration!.inHours).toString().padLeft(2, '0')}:'
        '${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:'
        '${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${(count.inHours).toString().toString().padLeft(2, '0')}:'
        '${(count.inMinutes % 60).toString().padLeft(2, '0')}:'
        '${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  double progress = 1.0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(
          hours: widget.hours,
          minutes: widget.minutes,
          seconds: widget.seconds),
    );

    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);

    controller.addListener(() {
      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          progress = 1.0;
          isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF1744),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 100),
            child: Text(
              'Countdown Timer',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: CircularProgressIndicator(
                    backgroundColor: const Color(0x47FFFFFF),
                    value: progress,
                    strokeWidth: 8,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (controller.isDismissed) {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          height: 300,
                          child: CupertinoTimerPicker(
                            initialTimerDuration: controller.duration!,
                            onTimerDurationChanged: (time) {
                              setState(() {
                                controller.duration = time;
                              });
                            },
                          ),
                        ),
                      );
                    }
                  },
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) => Text(
                      countText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (controller.isAnimating) {
                      controller.stop();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      controller.reverse(
                          from: controller.value == 0 ? 1.0 : controller.value);
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                  child: Button(
                    icon: isPlaying
                        ? MyFlutterApp.pause_outline
                        : MyFlutterApp.play_outline,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.reset();
                    setState(() {
                      isPlaying = false;
                    });
                    Navigator.pop(context);
                  },
                  child: const Button(
                    icon: MyFlutterApp.stop_outline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}