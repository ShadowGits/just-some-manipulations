import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:word_clouding/checkScreen.dart';
import 'package:word_clouding/constants.dart';

import 'ActionButton.dart';
import 'custom_radiobutton_icon_group.dart';
import 'size_config.dart';

File imageMask;
bool gotMask=false;
class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  String _textInput = "Check Data";
  List<bool> _buttonChoices = [false, false];

  var _controller = TextEditingController();

  void refreshWidget(choices) {
    setState(() {
      _buttonChoices = List.from(choices);
    });
  }

  @override
  Widget build(BuildContext context) {
    var horizVal = displaySafeWidthBlocks(context);
    var vertVal = displaySafeHeightBlocks(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Cloud's Overrated?"),
        actions:<Widget>[ IconButton(
          icon:Icon(Icons.refresh),
          onPressed:(){
            setState(() {

            });
          },
        ),]
      ),
      drawer: Drawer(
          child: Column(
        children: <Widget>[
          SizedBox(
            height: 2*vertVal,
          ),
          Container(
            height: 10 * vertVal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 40,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                VerticalDivider(
                  thickness: 3,
                ),
                Text(
                  "Help Yourself",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                  fontSize: 18),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 2,
            color: Colors.pink,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: drawerItems.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(width: 2*horizVal,),
                    FlutterLogo(),
                    SizedBox(width: 2*horizVal,),

                    ListViewCardTile(index),
                  ],
                );
              },
            ),
          ),
        ],
      )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              inputTextFieldWidgetState(vertVal, horizVal),
              getMaskInformation(vertVal,horizVal),
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
          CustomRadioButtonIconGroup(
              notifyParent: refreshWidget, buttonChoices: _buttonChoices),
          SizedBox(
            width: 2 * vertVal,
          ),
          Expanded(
            child: ActionButton(
              ontap: () async {
                if (_buttonChoices[0]) {
                  _controller.clear();
                } else if (_buttonChoices[1]) {
                  Navigator.pushReplacementNamed(context, '/Display',
                      arguments: [_textInput,gotMask,imageMask]);
                } else {}
              },
              width: 25 * horizVal,
              height: vertVal * 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget getMaskInformation(double vertVal,double horizVal){
    if(gotMask){
      return Card(
        child: Container(
          width: 90*horizVal,
          height: 10*vertVal,
          child:Row(
            children: <Widget>[
              Text("Mask Obtained"),
              Icon(Icons.assignment_turned_in),
              Image.file(imageMask),
            ],
          )
        ),
      );

    }
    return SizedBox();
  }
}






class ListViewCardTile extends StatefulWidget {
  @override
  _ListViewCardTileState createState() => _ListViewCardTileState();
  final int index;
  ListViewCardTile(this.index);
}

class _ListViewCardTileState extends State<ListViewCardTile> {

  Future<bool> _pickImageFromGallery(ImageSource imageSource) async{
    imageMask=await ImagePicker.pickImage(source: imageSource);
    return imageMask!=null;
  }
  @override
  Widget build(BuildContext context) {
    var horizVal = displaySafeWidthBlocks(context);
    var vertVal = displaySafeHeightBlocks(context);

    return Align(
        child: Card(
          color: Colors.blueAccent,
          child: InkWell(
            onTap:() async{
              if(await _pickImageFromGallery(ImageSource.gallery))
                gotMask=true;
            },
            child: Container(
              height: 7 * vertVal,
              width: 66 * horizVal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 10 * horizVal,
                  ),
                  Text(drawerItems[widget.index]),
                  Icon(
                    Icons.child_care,
                    color: Colors.brown,
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
