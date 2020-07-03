import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import 'size_config.dart';

class CloudDisplay extends StatelessWidget {
  final String imageText;

  final String imageInvertText ;

  CloudDisplay({@required this.imageText, @required this.imageInvertText});



  @override
  Widget build(BuildContext context) {
    var horizVal = displaySafeWidthBlocks(context);
    var vertVal = displaySafeHeightBlocks(context);




    Future<List<File>> _write() async {
      final Directory directory = await getApplicationDocumentsDirectory();
      print(directory.path);
      final File file = File('${directory.path}/decodedCloud.png');
      final decodedBytes = base64Decode(imageText);
      await file.writeAsBytes(decodedBytes);
      final File fileI = File('${directory.path}/decodedCloudInvert.png');
      final decodedBytesI = base64Decode(imageInvertText);
      await fileI.writeAsBytes(decodedBytesI);

      print("IMAGE WRITTEN");
      return [file,fileI];
    }



         return FutureBuilder<List<File>>(
           future: _write(),
           builder: (BuildContext context,AsyncSnapshot<List<File>> snapshot) {
             return SafeArea(
               child: ListView.separated(
                 separatorBuilder: (context,index){
return SeparatorCustom();},

                 scrollDirection: Axis.horizontal,
itemCount: 2,
itemBuilder: (context,index)
                   {
                     return ImageFileWidget(vertVal: vertVal,horizVal: horizVal,imageFile: snapshot.data[index],);
                   }


               ),
             );
           }
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
            height: 80 * vertVal,
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
                child: Image.file(imageFile),
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
      child: Icon(Icons.arrow_forward_ios,
      color: Colors.pink,),
      height: 46 * vertVal,
      width: 10*horizVal,
      color: Colors.black12,
    );
  }
}
