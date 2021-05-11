import 'package:flutter/material.dart';
import 'package:newz_app/CounterBloc.dart';
import 'package:newz_app/notification.dart';
import 'package:provider/provider.dart';
class HomePage extends StatefulWidget {
  String title,descripton,image;

  HomePage(this.title,this.descripton,this.image);
@override
_HomePageStateState createState() => _HomePageStateState(title,descripton,image);
}

class _HomePageStateState extends State<HomePage> {
  String title,descripton,image;
  _HomePageStateState(this.title,this.descripton,this.image);
  @override
  void initState() {
    Provider.of<notificational>(context
        ,listen: false).initialize();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Consumer<notificational>(builder: (context,model,_) =>
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print("djfhkjd");
                      model.instatnotificationDetail(title,descripton,image); }
                    ,child: Text("instant Notification"),
                  ),
                  ElevatedButton(
                    onPressed: () => model.ImageNotification(descripton,image),child: Text("image Notification"),
                  ),
                  ElevatedButton(
                    onPressed: (){},child: Text("Media Notification"),
                  ),
                  ElevatedButton(
                    onPressed: (){},child: Text("Scheduled Notification"),
                  ),
                  ElevatedButton(
                    onPressed: (){},child: Text(" cancel Notification"),
                  ),
                ],
              ),
          ),
        ));
  }
}



