import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'size_config.dart';

class CustomRadioButtonIconGroup extends StatefulWidget {
  final Function notifyParent;
  final List<bool> buttonChoices;
  CustomRadioButtonIconGroup({@required this.notifyParent,@required this.buttonChoices});

  @override
  _CustomRadioButtonIconGroupState createState() => _CustomRadioButtonIconGroupState();
}

class _CustomRadioButtonIconGroupState extends State<CustomRadioButtonIconGroup> {

  List<Color> getColors(List<bool> choices)
  {
    List<Color> iconColors = [Colors.white, Colors.white];
    if(choices[0]){
      iconColors[0]=Colors.greenAccent;
    }
    else if(choices[1])
    {
      iconColors[1]=Colors.greenAccent;
    }
    return iconColors;
  }


  @override
  Widget build(BuildContext context) {
    var horizVal = displaySafeWidthBlocks(context);
    var vertVal = displaySafeHeightBlocks(context);

    var iconColors=getColors(widget.buttonChoices);

    return Container(
      width: 60*horizVal,
      height: 12*vertVal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: (){
                setState(() {
                  print(iconColors);
                  widget.notifyParent([true,false]);
                });
              },
              child: Icon(
                  Icons.refresh,
                color: iconColors[0],
                size: 10*horizVal,

              ),
            ),
          )
          , Expanded(child: Text("Reset")),
          Expanded(
            child: GestureDetector(
              onTap: (){
                  setState(() {

                    print(iconColors);
                    widget.notifyParent([false,true]);
                  });
                },
              child: Icon(

                Icons.cloud_circle,
                color:iconColors[1],
                size: 10*horizVal,
              ),
            ),
          ),
          Expanded(child: Text("Cloud")),
        ],
      ),
    );
  }
}
