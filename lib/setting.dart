import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
class setting extends StatefulWidget {
  @override
  _settingState createState() => _settingState();
}

class _settingState extends State<setting> {
  bool icon=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("setting"),
      ),
      body: Column(
        children: [
          Padding(

            padding: const EdgeInsets.only(top: 5,bottom: 5),
            child: Container(
              height: MediaQuery.of(context).size.width*0.40,
              width: MediaQuery.of(context).size.width,
              color: Colors.white38,
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text(
                         'choose Theme',
                         style: TextStyle(
                         color: Colors.white
                       ),
                       ),
                       Icon(
                         Icons.arrow_downward,color: Colors.white,size: 10,
                       ),
                     ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top:15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:80.0),
                            child: Stack(

                              children: [

                                Container(
                                  height: 85,
                                  width: 100,
                                  color: Colors.black,
                                  child: IconButton(
                                    onPressed: (){
                                      setState(() {
                                         icon=!icon;
                                      //  _themeChanger.setTheme(ThemeData.dark());

                                      });
                                    },
                                    icon:icon?Icon(
                                      Icons.album_outlined,
                                      color: Colors.white,
                                      size: 34,
                                    ):Icon(
                                    Icons.album_outlined,
                                    color: Colors.white38,
                                    size: 34,
                                  ),


                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(top:90,left: 30),
                                  child: Text(
                                    "Dark",style: TextStyle(
                                      color: Colors.white
                                  ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Stack(

                            children: [
                              Container(
                                height: 85,
                                width: 100,
                                color: Colors.blue,
                                child:IconButton(
                                  onPressed: (){
                                    setState(() {
                                      icon=!icon;
                                    //   _themeChanger.setTheme(ThemeData.light());

                                    });
                                  },
                                  icon: !icon?Icon(
                                    Icons.album_outlined,
                                    color: Colors.white,
                                    size: 34,
                                  ):Icon(
                                    Icons.album_outlined,
                                    color: Colors.white38,
                                    size: 34,
                                  ),


                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:90,left: 30),
                                child: Text(
                                  "Light",style: TextStyle(
                                    color: Colors.white,
                                ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){

            },
            child: Container(

              height: 45,
              width: MediaQuery.of(context).size.width,
              color: Colors.white38,
              child: Row(

                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:10),
                    child: Text("Choose your app Colors",style: TextStyle(
                      color: Colors.white
                    ),
                    ),
                  ),
                 Spacer(),
                 Icon(
                   Icons.arrow_forward_ios_rounded


                 )

                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
