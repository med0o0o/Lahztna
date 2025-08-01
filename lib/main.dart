import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'لحظتنا',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: Scaffold(
        appBar: AppBar(title: Text('لحظتنا')),
        body: Center(
          child: Text(
            'أهلاً يا أليسيو و فراشتك 🦋',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
