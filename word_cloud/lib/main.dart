import 'package:flutter/material.dart';

import 'size_config.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        backgroundColor: Color(0xFF00ABB0),
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
  @override
  Widget build(BuildContext context) {
    var horizVal = displaySafeWidthBlocks(context);
    var vertVal = displaySafeHeightBlocks(context);

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
                    {
                      _textInput=text;
                      print(_textInput);
                    },

                  ),
                ),
              ),

              FlatButton(


              )
            ],
          ),
        ),
      ),
    );
  }
}
