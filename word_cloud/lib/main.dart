import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:wordcloud/ActionButton.dart';
import 'package:wordcloud/API.dart';

import 'constants.dart';
import 'size_config.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(
      ),
      home: HomeTextEntry(),
    );
  }
}


class HomeTextEntry extends StatefulWidget {
  @override
  _HomeTextEntryState createState() => _HomeTextEntryState();
}

class _HomeTextEntryState extends State<HomeTextEntry> {

  String _textInput;
  String _buttonChoice;
  @override
  Widget build(BuildContext context) {
    var horizVal = displaySafeWidthBlocks(context);
    var vertVal = displaySafeHeightBlocks(context);

    Map<String,IconData> iconsGroupData={
      "Reset":Icons.autorenew,
      "Get Cloud":Icons.print
    };

    return Scaffold(
      appBar: AppBar(
        title: Text("Nails Hip Hair Heels"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 85*vertVal,
                width: 100*horizVal,
                child: Card(
                  child: TextField(
                    obscureText: false,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Yeah it goes here"
                    ),
                    onChanged: (text)
                    async {
                      _textInput=text;
                      print(_textInput);
                      var imageJson=await putImageInEncodedForm(url);
                      var decodeData=jsonDecode(imageJson);
                      print(decodeData['data']);
                    },
                  ),
                ),
              ),
          Padding(
            padding: const EdgeInsets.only(right:18.0,top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:<Widget>[
                RadioButtonGroup(
              orientation: GroupedButtonsOrientation.HORIZONTAL,
              margin: const EdgeInsets.only(left: 12.0),
              onSelected: (String selected) => setState((){
                _buttonChoice = selected;
              }),
              labels: <String>[
                "Reset",
                "Get Cloud",
              ],
              picked: _buttonChoice,
              itemBuilder: (Radio rb, Text txt, int i){
                return Row(
                  children: <Widget>[
                    rb,
                    txt,
                  ],
                );
              },
        ),
                ActionButton(
                  ontap: () {

                  },
                  width: 25*horizVal,
                  height: vertVal*6,
                ),
              ],
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }
}
