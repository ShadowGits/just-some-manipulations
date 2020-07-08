import 'dart:convert';
import 'dart:io';

import "package:http/http.dart" as http;

//AWAIT
//Future<String> putImageInEncodedForm(String url,String text) async {
//  Map<String, String> headers = {"Content-type": "application/json"};
//  var body = jsonEncode({'input_text': text});
//  http.Response response = await http.post(url, headers: headers, body: body);
//  print(response.body.toString());
//  return response.body;
//}
//


//THEN

Future<String> putImageInEncodedForm(String url,String text) {
  Map<String, String> headers = {"Content-type": "application/json"};
  var body = jsonEncode({'input_text': text});
  return http.post(url,headers: headers,body: body).then((response){
    return response.body;
  });
}
//
//Future<String> getImageInEncodeForm(String url) async {
//  http.Response response = await http.get(url);
//  return response.body;
//}



Future<String> getImageInEncodeForm(String url) {
  return http.get(url).then((response){
    return response.body;
  });
}
//
//Future<String> putImageInEncodedFormWithCustomMask(String url,String text,File imageMask) async {
//  String maskString=base64Encode(await imageMask.readAsBytes());
//  print(maskString.substring(0,10));
//  print(url);
//  Map<String, String> headers = {"Content-type": "application/json"};
//  var body = jsonEncode({'input_text': text,
//                          'mask_string':maskString});
//  http.Response response = await http.post(url, headers: headers, body: body);
//  print(response.body.toString());
//  return response.body;
//}



Future<String> putImageInEncodedFormWithCustomMask(String url,String text,File imageMask) {
  String maskString=base64Encode(imageMask.readAsBytesSync());
  print(maskString.substring(0,10));
  print(url);
  Map<String, String> headers = {"Content-type": "application/json"};
  var body = jsonEncode({'input_text': text,
    'mask_string':maskString});
  return http.post(url,headers: headers,body: body).then((response){
    return response.body;
  });
}


