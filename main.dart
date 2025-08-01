import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

void main() {
  runApp(LahztnaApp());
}

class LahztnaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'لحظتنا',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Cairo',
      ),
      home: LoveCounterPage(),
    );
  }
}

class LoveCounterPage extends StatefulWidget {
  @override
  _LoveCounterPageState createState() => _LoveCounterPageState();
}

class _LoveCounterPageState extends State<LoveCounterPage> {
  DateTime loveStartDate = DateTime(2025, 5, 15, 15, 0, 0);
  Duration loveDuration = Duration();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    updateLoveDuration();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      updateLoveDuration();
    });
  }

  void updateLoveDuration() {
    final now = DateTime.now();
    setState(() {
      loveDuration = now.difference(loveStartDate);
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String formatDuration(Duration d) {
    final days = d.inDays;
    final hours = d.inHours % 24;
    final minutes = d.inMinutes % 60;
    final seconds = d.inSeconds % 60;
    return '$days يوم - $hours ساعة - $minutes دقيقة - $seconds ثانية';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '⏳ مر على لقائنا الأول:',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                formatDuration(loveDuration),
                style: TextStyle(fontSize: 24, color: Colors.pink.shade900),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              Text(
                'منذ لحظة تعارف أليسو و فراشته ماريبوسا 🦋',
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              Icon(Icons.favorite, color: Colors.pink, size: 60),
            ],
          ),
        ),
      ),
    );
  }
}
