

import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final Function ontap;
  final double width;
  final double height;

  ActionButton({this.title, @required this.ontap,@required this.width,@required this.height});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xFFEB1555),
          border:  Border.all(width: 2,color:Color(0xFF000000),style: BorderStyle.solid),
          borderRadius: BorderRadius.all(Radius.circular(10
          ),
          )
        ),
        child: Center(
          child: Icon(Icons.check_circle_outline)
        ),
        width: width,
        height: height,
      ),
    );
  }
}
