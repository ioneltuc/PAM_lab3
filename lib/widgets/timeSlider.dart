import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class TimeSlider extends StatefulWidget {
  const TimeSlider({
    Key? key,
    required this.maxValue,
    required this.currentValue,
    required this.text,
    required this.onChangedValue,
  }) : super(key: key);
  final int maxValue;
  final int currentValue;
  final String text;
  final ValueChanged<int> onChangedValue;

  @override
  _TimeSliderState createState() => _TimeSliderState();
}

class _TimeSliderState extends State<TimeSlider> {
  int _currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(33, 44, 50, 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: NumberPicker(
            selectedTextStyle: TextStyle(color: Colors.white, fontSize: 40),
            itemHeight: 80,
            itemWidth: 80,
            itemCount: 1,
            value: _currentValue,
            minValue: 0,
            maxValue: widget.maxValue,
            step: 1,
            haptics: true,
            onChanged: (value) => setState(() {
              _currentValue = value;
              widget.onChangedValue(value);
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            widget.text,
            style: const TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}