import 'package:flutter/material.dart';
import 'package:lab3/pages/secondPage.dart';
import 'package:lab3/widgets/timeSlider.dart';
import '../icons/my_flutter_app_icons.dart';
import '../widgets/button.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int hours = 0;
  int minutes = 0;
  int seconds = 0;

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
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TimeSlider(
                    maxValue: 99,
                    currentValue: hours,
                    text: 'hour(s)',
                    onChangedValue: (value) => setState(() => hours = value),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                    child: Text(
                      ':',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  TimeSlider(
                    maxValue: 59,
                    currentValue: minutes,
                    text: 'minute(s)',
                    onChangedValue: (value) => setState(() => minutes = value),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                    child: Text(
                      ':',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  TimeSlider(
                    maxValue: 59,
                    currentValue: seconds,
                    text: 'second(s)',
                    onChangedValue: (value) => setState(() => seconds = value),
                  ),
                ],
              )
            ],
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (hours == 0 && minutes == 0 && seconds == 0) {
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SecondPage(
                              hours: hours,
                              minutes: minutes,
                              seconds: seconds)),
                    );
                  },
                  child: Button(
                    icon: MyFlutterApp.play_outline,
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
