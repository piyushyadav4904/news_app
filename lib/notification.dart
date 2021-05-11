import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class notificational
     extends ChangeNotifier{
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
  Future instatnotificationDetail(String title,String body,String image) async{
    var android = AndroidNotificationDetails("id", "channel", "description");
    var ios = IOSNotificationDetails();
    var platfrom = new NotificationDetails(android: android,iOS: ios);
    var scheduledDate = Time(14,39,0);
       String substring= title.substring(0,50)+"...";

    await _flutterLocalNotificationsPlugin.show(0, substring,body,platfrom,payload: "dfjdjfadfladlsfk");

  }
  Future  ImageNotification(String body,String image) async{

    var bigPicture = BigPictureStyleInformation(
      DrawableResourceAndroidBitmap(image),
      largeIcon : DrawableResourceAndroidBitmap("photo"),
      contentTitle: "this is mine image notification",
      summaryText: "bvnbvnmvmnbmnbnmb",
      htmlFormatContent: true,
      htmlFormatContentTitle: true,
    );
    var android = AndroidNotificationDetails("id", "channel", "description",styleInformation: bigPicture);
    var platfrom = new NotificationDetails(android: android );
    await _flutterLocalNotificationsPlugin.show(0,
        "this is my title ", "this is my bodyjkhkjfhasdkjfhadsjfhadsjlfhadsfkajdsaafhkadsjfhksdjfakfhkadsjfhksadjfhsdkjfh", platfrom,payload: "welcome my first local notification");
    print("hbcjhadsbadbch");
  }
}
