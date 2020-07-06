import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loader/loader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:word_clouding/cloud_display.dart';

import 'API.dart';
import 'constants.dart';

class DataFetch extends StatefulWidget {
  final String _textInput;
  DataFetch(this._textInput);

  @override
  _DataFetchState createState() => _DataFetchState();
}

class _DataFetchState extends State<DataFetch> with LoadingMixin<DataFetch> {


  Future<List<String>> _getImageStrings()
  async{
                String textInput=widget._textInput;
                var parsed;
                List<String> imageStrings=["","","",""];
                if (textInput == 'Check Data' || textInput.length == 0) {
                  parsed = await getImageInEncodeForm(url);
                }
                else {
                  parsed = await putImageInEncodedForm(url, textInput);
                }

                var jsonData = json.decode(parsed);
                imageStrings[0] = jsonData['image_string'];

                imageStrings[1] = jsonData['image_string_invert'];
                imageStrings[2] = jsonData['image_string_masked'];
                imageStrings[3] = jsonData['image_string_invert_masked'];

                print("DATA FETCHED");
                return imageStrings;
  }


  Future<List<File>> _write1() async {
    List<String> imageStrings= await _getImageStrings();


    final Directory directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    final File file = File('${directory.path}/decodedCloud.png');
    final decodedBytes = base64Decode(imageStrings[0]);
    await file.writeAsBytes(decodedBytes);
    print("IMAGE WRITTEN");

    final File fileI = File('${directory.path}/decodedCloudInvert.png');
    final decodedBytesI = base64Decode(imageStrings[1]);
    await fileI.writeAsBytes(decodedBytesI);
    print("IMAGE WRITTEN");

    final File fileM = File('${directory.path}/decodedCloudMasked.png');
    final decodedBytesM = base64Decode(imageStrings[2]);
    await fileM.writeAsBytes(decodedBytesM);
    print("IMAGE WRITTEN");

    final File fileIM = File('${directory.path}/decodedCloudInvertMasked.png');
    final decodedBytesIM = base64Decode(imageStrings[3]);
    await fileIM.writeAsBytes(decodedBytesIM);
    print("IMAGE WRITTEN");

    return [file,fileI,fileM,fileIM];
  }




  List<File> _imageFiles;


  @override
  Future<void> load() async {
    _imageFiles=await _write1();
  }



  @override
  Widget build(BuildContext context) {
    if(loading) {
      return SafeArea(

        child: Container(
          color: Colors.black12,
          child: Center(
            child: CollectionScaleTransition(
              children: <Widget>[
                Icon(Icons.android, size: 30,),
                Icon(Icons.apps, size: 30,),
                Icon(Icons.announcement, size: 30,)

              ],
            ),
          ),
        ),
      );
    }
    else{
      return WillPopScope(onWillPop: _onBackPressed,
          child: CloudDisplay(files: _imageFiles,));
    }
  }



   Future<bool> _onBackPressed() async{
    print("triggered");
    var k=await Navigator.pushReplacementNamed(context, '/Home');
    print(k);
    return k;
  }
}
