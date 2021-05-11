import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class LocalNotificationclass extends ChangeNotifier {
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
    var scheduledDate = Time(9,9,0);

    await _flutterLocalNotificationsPlugin.showDailyAtTime(0, "vhgvhj", "hjghfdgh", scheduledDate, platfrom);

  }

/* Future  ImageNotification() async{


      String bitmap = await Bitmap.fromProvider(NetworkImage("http://pudim.com.br/pudim.jpg")).toString();

    var bigPicture = BigPictureStyleInformation(
        DrawableResourceAndroidBitmap("photo"),
        largeIcon : DrawableResourceAndroidBitmap('bitmap'),
        contentTitle: "this is mine image notification",
        summaryText: "this is summarytext filed",
        htmlFormatContent: true,
      htmlFormatContentTitle: true,
    );
    var android = AndroidNotificationDetails("id", "channel", "description",styleInformation: bigPicture);
    var platfrom = new NotificationDetails(android: android );
    await _flutterLocalNotificationsPlugin.show(0,
        "this is my title ", "this is my body", platfrom,payload: "welcome my first local notification");
    print("hbcjhadsbadbch");
 }*/
}