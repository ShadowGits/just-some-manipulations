import 'dart:convert';

import "package:http/http.dart" as http;

Future<String> putImageInEncodedForm(String url) async{
  Map<String, String> headers = {"Content-type": "application/json"};
  var body=jsonEncode({
    'encoded_image':'fghjkojihug'
  });
  http.Response response=await http.post(url,headers: headers,body:body);
  print(response.body.toString());
  return response.body;
}

Future<String> getImageInEncodeForm(String url){

}