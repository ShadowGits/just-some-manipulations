import 'dart:convert';

import "package:http/http.dart" as http;

Future<String> putImageInEncodedForm(String url,String text) async {
  print(text);
  Map<String, String> headers = {"Content-type": "application/json"};
  var body = jsonEncode({'input_text': text});
  http.Response response = await http.post(url, headers: headers, body: body);
  print(response.body.toString());
  return response.body;
}

Future<String> getImageInEncodeForm(String url) async {
  http.Response response = await http.get(url);
  return response.body;
}
