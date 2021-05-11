import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newz_app/main.dart';
import 'package:webview_flutter/webview_flutter.dart';
class wbview extends StatefulWidget {
   Album recordObject;

  wbview(Album record){
    this.recordObject=record;
  }
  @override
  webview_State createState() => webview_State(recordObject);
}

class webview_State extends State<wbview> {
   Album recordObject;
   bool loading= true;
  webview_State(this. recordObject);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('newzapp')),

        body:Stack(
          children: [
            WebView(
              initialUrl: recordObject.url,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (String url){setState(() {
            print("fadsjfha");
            loading=false;
            });
            }


            ),
            loading?Scaffold(
              body: Center(
                child: Container(
                  width: 200.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child:Column(
                    children: [

                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: new CircularProgressIndicator(
                          backgroundColor: Colors.white,

                      ),
                       ),
                      Text("please wait..",style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,


                      ),

                      ),
                    ],
                  )

                ),
              ),
            ):Stack()

          ],

        )
    );
  }




}


