
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:word_clouding/InputScreen.dart';
import 'package:word_clouding/data_fetch.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: InputScreen(),
      onGenerateRoute: (settings)
      {
        if(settings.name=="/Display")
        {
          return MaterialPageRoute(builder: (context)
          {
            return DataFetch(settings.arguments);
          });
        }

            return MaterialPageRoute(builder: (context)=>InputScreen());
      },

    );
  }
}
