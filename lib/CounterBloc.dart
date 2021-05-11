import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CounterBloc with ChangeNotifier {
  ThemeData _themdata;
  String country1 ;


  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin() ;

  Future initialize() async{
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin= FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings= AndroidInitializationSettings("photo");
    IOSInitializationSettings iosInitializationSettings= IOSInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings,iOS: iosInitializationSettings
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
  Future instatnotificationDetail() async{
    var android = AndroidNotificationDetails("id", "channel", "description");
    var ios = IOSNotificationDetails();
    var platfrom = new NotificationDetails(android: android,iOS: ios);
    var scheduledDate = Time(9,20,0);

    await _flutterLocalNotificationsPlugin.showDailyAtTime(0, "vhgvhj", "hjghfdgh", scheduledDate, platfrom);

  }
  CounterBloc(this._themdata);

  setString(String country){
    this.country1 = country;
     print("jhgfhgfhf");
     notifyListeners();
  }
  getstring(){
    print(country1);
    return country1;
  }


  setTheme(ThemeData _themedata){
    _themdata =_themedata;
    notifyListeners();
  }
  getTheme() => _themdata;


}