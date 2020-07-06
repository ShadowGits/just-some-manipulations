import 'package:flutter/material.dart';

import 'ActionButton.dart';
import 'custom_radiobutton_icon_group.dart';
import 'size_config.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  String _textInput="Check Data";
  List<bool> _buttonChoices=[false,false];


  var _controller = TextEditingController();

  void refreshWidget(choices){
    setState(() {
      _buttonChoices=List.from(choices);
    });
  }


  @override
  Widget build(BuildContext context) {
    var horizVal = displaySafeWidthBlocks(context);
    var vertVal = displaySafeHeightBlocks(context);


    return Scaffold(
      appBar: AppBar(
        title: Text("Cloud's Overrated?"),),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                inputTextFieldWidgetState(vertVal, horizVal),
                getButtonGroup(context, horizVal, vertVal),

              ],
            ),
          ),
        ),
    );
  }

  Container inputTextFieldWidgetState(double vertVal, double horizVal) {
    return Container(
      height: 83 * vertVal,
      width: 94 * horizVal,
      child: Card(
        margin: EdgeInsets.all(0),
        child: TextField(
          controller: _controller,
          obscureText: false,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(
              border: InputBorder.none, hintText: "  Yeah it goes here"),
          onChanged: (text) {
            _textInput = text;
          },
        ),
      ),
    );
  }

  Padding getButtonGroup(
      BuildContext context, double horizVal, double vertVal) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          CustomRadioButtonIconGroup(notifyParent:refreshWidget,buttonChoices:_buttonChoices),
          SizedBox(
            width: 2*vertVal,
          ),
          Expanded(
            child: ActionButton(
              ontap: () async {
                if (_buttonChoices[0]) {
                  _controller.clear();
                }
                else if (_buttonChoices[1]) {

                  Navigator.pushReplacementNamed(context, '/Display',arguments: _textInput);

                }

                else{

                }
              },
              width: 25 * horizVal,
              height: vertVal * 6,
            ),
          ),
        ],
      ),
    );
  }
}
