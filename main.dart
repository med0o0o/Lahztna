
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  runApp(MyApp());
}

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);
    await _flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails);
  }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime startDate = DateTime(2025, 5, 15, 15, 0, 0);
  late Duration duration;

  @override
  void initState() {
    super.initState();
    duration = DateTime.now().difference(startDate);
    Future.delayed(Duration(seconds: 1), updateTimer);
  }

  void updateTimer() {
    setState(() {
      duration = DateTime.now().difference(startDate);
    });
    Future.delayed(Duration(seconds: 1), updateTimer);
  }

  @override
  Widget build(BuildContext context) {
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("لحظتنا")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("منذ تعارفكم:", style: TextStyle(fontSize: 24)),
              Text("$days يوم - $hours ساعة - $minutes دقيقة - $seconds ثانية",
                  style: TextStyle(fontSize: 22)),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  NotificationService().showNotification("تذكير من لحظتنا", "مرت $days يوم منذ تعارفكم!");
                },
                child: Text("جرب إشعار ❤️"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
