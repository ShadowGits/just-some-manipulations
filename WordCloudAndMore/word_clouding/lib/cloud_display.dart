import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import 'size_config.dart';

var current=1;
class CloudDisplay extends StatefulWidget {

  final List<File> files;
  CloudDisplay({@required this.files});

  @override
  _CloudDisplayState createState() => _CloudDisplayState();
}

class _CloudDisplayState extends State<CloudDisplay> {


  @override
  Widget build(BuildContext context) {
    var horizVal = displaySafeWidthBlocks(context);
    var vertVal = displaySafeHeightBlocks(context);

    File imageFile=widget.files[current-1];

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 80 * vertVal,
            width: 100 * horizVal,
child: ImageFileWidget(vertVal: vertVal, horizVal: horizVal, imageFile: imageFile),
//            child: ListView.separated(
//                separatorBuilder: (context, index) {
//                  return SeparatorCustom();
//                },
//
//                scrollDirection: Axis.vertical,
//                itemCount: 2,
//                itemBuilder: (context, index) {
//                  return ImageFileWidget(vertVal: vertVal,
//                    horizVal: horizVal,
//                    imageFile:imageFiles[index] ,);
//                }
//
//
//            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  setState(() {
                    if(current==1)
                      current=3;
                    else if(current==3)
                      current=1;
                    else if(current==2)
                      current=4;
                    else
                      current=2;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.red)
                ),
                child: Text("MASK/UNMASK"),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    if(current==1)
                      current=2;
                    else if(current==2)
                      current=1;
                    else if(current==3)
                      current=4;
                    else
                      current=3;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.red)
                ),
                child: Text("INVERT"),
              ),
            ],
          ),

        ],
      ),
    );
  }

}

class ImageFileWidget extends StatelessWidget {
  const ImageFileWidget({
    Key key,
    @required this.vertVal,
    @required this.horizVal,
    @required this.imageFile
  }) : super(key: key);

  final double vertVal;
  final double horizVal;
  final File imageFile;

  @override
  Widget build(BuildContext context) {


          return Container(
            height: 40 * vertVal,
            width: 90 * horizVal,
            child: Card(
              color: Colors.black,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 5,
              child: Container(
                width: 90*horizVal,height: 70*vertVal,
                child:Image.file(imageFile)
              ),
        ),
          );
      }
}



class SeparatorCustom extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var horizVal = displaySafeWidthBlocks(context);
    var vertVal = displaySafeHeightBlocks(context);
    return Container(
      height: 1 * vertVal,
      width: 10*horizVal,
      color: Colors.black12,
    );
  }
}
