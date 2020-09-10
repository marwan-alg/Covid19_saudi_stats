import 'file:///C:/Users/memo_/AndroidStudioProjects/covid_tracker/lib/constant.dart';
import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  final int number;
  final Color color;
  final String title;
  const Counter({
    Key key,
    this.number,
    this.color,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(6),
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(.26),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: color,
                width: 2,
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        Text('$title: ',
            style: TextStyle(fontSize: 25, color: kTextLightColor)),
        Text(
          "$number",
          style: TextStyle(
            fontSize: 30,
            color: color,
          ),
        ),
      ],
    );
  }
}
