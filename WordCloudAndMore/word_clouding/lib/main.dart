import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:word_clouding/custom_radiobutton_icon_group.dart';
import 'API.dart';
import 'ActionButton.dart';

import 'cloud_display.dart';
import 'constants.dart';
import 'size_config.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: HomeTextEntry(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeTextEntry extends StatefulWidget {
  @override
  _HomeTextEntryState createState() => _HomeTextEntryState();
}

class _HomeTextEntryState extends State<HomeTextEntry> {
  String _textInput="Check Data";
  List<bool> _buttonChoices=[false,false];
  String imageString = "check String";
  String imageStringInvert = "checkString";

  var _controller = TextEditingController();

  void refreshWidget(choices){
    setState(() {
      _buttonChoices=List.from(choices);
    });
  }


  @override
  Widget build(BuildContext context) {
    print("Created Again");
    var horizVal = displaySafeWidthBlocks(context);
    var vertVal = displaySafeHeightBlocks(context);


    return Scaffold(
      appBar: AppBar(
        title: Text("Cloud's Overrated?"),
      ),
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
                var parsed;
                if (_textInput=='Check Data' || _textInput.length==0)
                  {
                    parsed = await getImageInEncodeForm(url);
                  }
                else {
                  parsed = await putImageInEncodedForm(url, _textInput);
                }

                var jsonData = json.decode(parsed);
                imageString = jsonData['image_string'];
                imageStringInvert = jsonData['image_string_invert'];
                String k = imageString.substring(0, 10);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CloudDisplay(
                          imageText: imageString,
                          imageInvertText: imageStringInvert),
                    ));
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
