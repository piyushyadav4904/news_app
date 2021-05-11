import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:newz_app/LocalNotification.dart';
import 'package:newz_app/cheakchip.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newz_app/notification.dart';
import 'package:newz_app/onborading%20screen.dart';
import 'package:newz_app/setting.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'CounterBloc.dart';
import 'webview.dart';
import 'setting.dart';
import 'dart:async';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:provider/provider.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<CounterBloc>(
        builder: (_) => CounterBloc(ThemeData.dark()),
        child :MyApp2());

  }
}
class MyApp2 extends StatelessWidget {
  CounterBloc _themeChager;
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    _themeChager = Provider.of<CounterBloc>(context);
        return MaterialApp(
              title: 'head shorts',
              theme: _themeChager.getTheme(),
              home: MyHomePage(title: 'heads shorts')
        );


  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Widget appBarTitle = new Text("AppBar Title");
  bool isswitch=true;
  Icon actionIcon = new Icon(Icons.search);
  TextEditingController searchcontroller = new TextEditingController();
  List<Album> users = [];
  List<int> _likes = List.generate(1000, (index) => index);
  // List<Note> noteList;
  CounterBloc _themeChager;


  @override
  Widget build(BuildContext context) {
    _themeChager = Provider.of<CounterBloc>(context);
    String  title,description,image;

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return WillPopScope(
      onWillPop:  () async => showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(title: Text('Thankyou for using our app'),
                  actionsPadding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  actions: <Widget>[
                SizedBox(
                  height: 75,
                  width: 75,
                  child: Center(
                    child: RaisedButton(
                        child: Text('ok',
                        style: TextStyle(
                          color: Colors.white
                        ),),
                        color: Colors.blueGrey,
                        onPressed: () => Navigator.of(context).pop(true)),
                  ),
                ),

              ])),
      child: Scaffold(
        appBar: AppBar(title: appBarTitle  ,
          actions:<Widget>[
            new IconButton(icon: actionIcon,onPressed:(){
              setState(() {
                if ( this.actionIcon.icon == Icons.search){
                  this.actionIcon = new Icon(Icons.close);
                  this.appBarTitle = new TextField(

                    style: new TextStyle(
                      color: Colors.white,



                    ),
                    cursorColor: Colors.white,
                    controller: searchcontroller,
                    onTap: (){
                      searchcontroller.addListener(() {
                        searchengine();
                      });
                    },
                    decoration: new InputDecoration(

                        contentPadding: const EdgeInsets.symmetric(vertical: 2.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide:  BorderSide(color: Colors.white30 ),),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide:  BorderSide(color: Colors.white ),),
                        prefixIcon: new Icon(Icons.search,color: Colors.white),
                        hintText: "Search...",
                        hintStyle: new TextStyle(color: Colors.white)
                    ),
                  );}
                else {
                  this.actionIcon = new Icon(Icons.search);
                  this.appBarTitle = new Text("AppBar Title");
                }


              });
            } ,),]

          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.

        ),
        body: Container(
            child:
            Consumer<CounterBloc>(builder: (context,model,_) =>
               FutureBuilder(
                  future:  fetchAlbum(model.getstring()),
                  // ignore: missing_return
                  builder: ( context, snapshot ) {
                    if (snapshot.hasData) {

                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context,

                              int index) {
                                title=snapshot.data[5].titl;
                                description=snapshot.data[5].description;
                                image=snapshot.data[5].urlToImage;
                              return Card(
                                color: Colors.black54,
                                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                borderOnForeground: true,
                                semanticContainer: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),

                                child: Column(
                                    children: [
                                      GestureDetector(
                                       /* onDoubleTap: () {
                                          final fido = Note(
                                            'gakjfghka',
                                            'Fido',
                                            'jdfhhakga',
                                            'dfhkasdjfghf',

                                          );
                                          DatabaseHelper helper = DatabaseHelper();
                                          var result = helper.insertNote(fido);

                                          print(result);
                                        },*/
                                        onTap: () {
                                          Navigator.push(context,
                                              new MaterialPageRoute(
                                                  builder: (context) =>
                                                      wbview(
                                                        snapshot.data[index],))
                                          );
                                        },

                                        child: Column(
                                            children: [

                                              ClipRRect(
                                                  borderRadius: BorderRadius
                                                      .circular(20),


                                                  child: FadeInImage.assetNetwork(
                                                    height: 300,
                                                    width: 500,
                                                    placeholder: 'assets/image.jpg',
                                                    image: snapshot.data[index]
                                                        .urlToImage == null
                                                        ? 'https://www.google.com/imgres?imgurl=https%3A%2F%2Fimages.unsplash.com%2Fphoto-1547483238-2cbf881a559f%3Fixlib%3Drb-1.2.1%26ixid%3DMXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MjV8fHxlbnwwfHx8%26w%3D1000%26q%3D80&imgrefurl=https%3A%2F%2Funsplash.com%2Fbackgrounds&tbnid=mu-8VWM88qe2IM&vet=12ahUKEwir6IrDx_3tAhW6h0sFHa7cB0kQMygKegUIARC5AQ..i&docid=b6YOYbz4PifiGM&w=1000&h=1500&q=unsplash%20background%20images&ved=2ahUKEwir6IrDx_3tAhW6h0sFHa7cB0kQMygKegUIARC5AQ'
                                                        : snapshot.data[index]
                                                        .urlToImage,

                                                    fit: BoxFit.fill,

                                                  )
                                              ),


                                              Container(
                                                height: 75,
                                                child: Center(child: Text(
                                                  snapshot.data[index].titl,
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 20.0,
                                                      color: Colors.white),
                                                ),

                                                ),
                                              ),
                                              Container(
                                                height: 100,

                                                child: Text(
                                                  snapshot.data[index]
                                                      .description == null
                                                      ? 'for description click tile'
                                                      : snapshot.data[index]
                                                      .description,
                                                  maxLines: 3,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 15.0,
                                                    color: Colors.white70,
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                color: Colors.white,
                                              ),
                                            ]),
                                      ),
                                      Row(children: [

                                        IconButton(
                                          iconSize: 35.0,
                                          icon: _likes[index] == 0
                                              ? Icon(Icons.favorite_border,
                                            color: Colors.white,)
                                              : Icon(Icons.favorite,
                                            color: Colors.green,),
                                          onPressed: () {
                                            setState(() {
                                              print("jhakjghsdjkfgs");
                                              print(_likes[index]);
                                              if (_likes[index] == 1) {
                                                return
                                                  _likes[index] = 0;
                                              }
                                              return _likes[index] = 1;
                                            });
                                          },),
                                        IconButton(
                                            onPressed: () {
                                              print("fmgnjksg");

                                              Share.share(
                                                  snapshot.data[index].url,
                                                  subject: 'newz app');
                                            },
                                            icon: Icon(Icons.share,
                                              size: 35.0,
                                              color: Colors.white,)

                                        ),
                                        Spacer(
                                        ),
                                        Text(

                                          _dateandtime(
                                              snapshot.data[index].publishedAt) +
                                              "  " + "hours",
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 20.0,
                                              color: Colors.white),
                                        ),


                                      ],

                                      ),


                                    ]),


                              );
                            }

                      );
                    } else {
                      print("hakughka");
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.blue,

                        ),
                      );
                    }
                  } ),
            )
        ),
        drawer: Padding(
          padding: EdgeInsets.fromLTRB(10, 10,50.0, 25.0),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25), bottomRight: Radius.circular(25),bottomLeft: Radius.circular(26),topLeft: Radius.circular(25)),
            child: Drawer(

              child: SafeArea(
                bottom: true,
                child: ListView(
                  children: [
                    Container(
                      height: 125,
                      color: Colors.black12,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1
                                  )
                                ),

                              ),
                              Text("A",style: TextStyle(
                                color:Colors.white,
                                fontSize: 20
                              ),

                              )
                            ],
                          ),
                          Text("piyush yadav",)
                        ],
                      ),

                    ),
                    Container(
                      height: 50,
                       color: Colors.black,

                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Flexible(
                              flex: 1,
                              child: IconButton(
                                onPressed: (){
                                 setState(() {

                                 });

                                },
                                icon: Icon(
                                  Icons.wb_sunny,
                                  color: Colors.amberAccent,
                                  size: 30,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Switch(
                                activeColor: Colors.deepPurpleAccent,
                                inactiveTrackColor: Colors.amberAccent,
                                inactiveThumbColor: Colors.amber,
                                value:isswitch,
                                onChanged:(bool value){
                                  setState(() {
                                    if(isswitch){
                                    isswitch = false;
                                    _themeChager.setTheme(ThemeData.light())
                                    ;
                                    }else{
                                   isswitch=true;
                                   _themeChager.setTheme(ThemeData.dark());
                                    }
                                    }
                                  );
                                }

                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: IconButton(
                                onPressed: (){

                                },
                                icon: Icon(
                                  Icons.nights_stay_outlined,
                                  size: 30,
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                            )
                          ],

                       ),
                    ),


                    ListTile(
                      contentPadding: EdgeInsets.only(left: 40),
                          horizontalTitleGap: -10,
                        onTap: (){
                          Navigator.push(context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      cheakchip()
                              ));

                        },

                        leading: Icon(Icons.flag_rounded,

                        ),
                        title: Text("Choose Country")), //cheakchips
                    ListTile(

                        contentPadding: EdgeInsets.only(left: 40),
                        horizontalTitleGap: -10,
                        leading: Icon(Icons.notifications_active,
                          ),
                         onTap: (){
                           Navigator.push(context,
                               new MaterialPageRoute(
                               builder: (context) =>
                                MultiProvider(
                                    child: HomePage(title,description,image),
                                  providers: [
                                    ChangeNotifierProvider(builder: (_) => notificational() ,)
                                  ],
                                )
                                 ));

                        },
                        title: Text("Set Notifiation time")),//notificatio
                    ListTile(
                        contentPadding: EdgeInsets.only(left: 40),
                        horizontalTitleGap: -10,
                        leading: Icon(Icons.work,
                          ),
                        onTap: (){
                          Navigator.push(context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      cheakchip()
                              ));

                        },
                        title: Text("Rate Us On Play Store")),//Rate us on play store
                    ListTile(
                        contentPadding: EdgeInsets.only(left: 40),
                        horizontalTitleGap: -10,
                        leading: Icon(Icons.feedback,
                          ),
                        onTap: (){
                          Navigator.of(context).pop();
                          _showalertDialog();

                        },
                        title: Text("Any feedback?")),//any feedback
                    ListTile(
                        contentPadding: EdgeInsets.only(left: 40),
                        horizontalTitleGap: -10,
                        leading: Icon(Icons.share_rounded,
                          ),
                        onTap: (){
                          Navigator.push(context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      cheakchip()
                              ));

                        },
                        title: Text("Share With a friend")),//share
                    ListTile(
                        contentPadding: EdgeInsets.only(left: 40),
                        horizontalTitleGap: -10,
                        leading: Icon(Icons.settings,
                        ),
                        onTap: (){
                          Navigator.push(context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      setting()
                              ));

                        },
                        title: Text("Setting")),//setting
                    ListTile(
                        contentPadding: EdgeInsets.only(left: 40),
                        horizontalTitleGap: -10,
                        leading: Icon(Icons.logout,
                          ),
                        onTap: (){
                          Navigator.push(context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      HomeScreen()
                              ));

                        },
                        title: Text("Logout")),//logout

                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          "Follow us on",style: TextStyle(

                          fontSize: 15

                        ),
                        ),
                      ),
                    ),
                Expanded(
                      flex: 1,
                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: ()
                            async {
                              const url = 'https://www.instagram.com/piyushyadav4904/';
                              if (await canLaunch(url)) {
                                await launch(url,
                                  universalLinksOnly: true,);
                              } else {
                                throw 'Could not launch $url';
                              }},

                            icon:  FaIcon(FontAwesomeIcons.instagramSquare,size: 30,),
                            ),//telgram and facebook and insta button using the url launcher
                          IconButton(
                            onPressed: () async {
                              const url = 'https://twitter.com/PiyushY15326907';
                              if (await canLaunch(url)) {
                                await launch(url,
                                  universalLinksOnly: true,);
                              } else {
                                throw 'Could not launch $url';
                              }},
                            icon: FaIcon(FontAwesomeIcons.twitterSquare,size: 30,),
                          ),
                          IconButton(
                            onPressed: ()async {
                              const url = 'https://www.facebook.com/profile.php?id=100016567959104';
                              if (await canLaunch(url)) {
                                await launch(url,
                                  universalLinksOnly: true,);
                              } else {
                                throw 'Could not launch $url';
                              }},
                           icon: FaIcon(FontAwesomeIcons.facebookSquare,size: 30,),


                            ),
                          IconButton(
                            onPressed: ()async {
                                const url = 'https://www.linkedin.com/in/piyush-y-ba7879176/';
                                     if (await canLaunch(url)) {
                                     await launch(url,
                                       universalLinksOnly: true,);
                                          } else {
                              throw 'Could not launch $url';
                                }},
                            icon: FaIcon(FontAwesomeIcons.linkedinIn,size: 30,),
                          ),
                          IconButton(
                            onPressed: ()
                              async {
                                const url = 'https://web.telegram.org/#/im';
                                if (await canLaunch(url)) {
                              await launch(url,
                              universalLinksOnly: true,);
                              } else {
                              throw 'Could not launch $url';
                              }},


                            icon: FaIcon(FontAwesomeIcons.telegram,size: 30,),
                          )
                        ],
                      ),
                    )

                  ],


                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }


  Future<List<Album>> fetchAlbum(String country) async {


    var response;
    switch(country) {
      case "china": {
        response = await http.get(
            'https://newsapi.org/v2/top-headlines?country=ar&apiKey=7f8dbc4d1d0046348b76408c8bd5dd52');
      }
      break;
      case "india": {
        print("india me gya ");
        response = await http.get(
          'http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=7f8dbc4d1d0046348b76408c8bd5dd52');}
      break;



      case "C": {  }
      break;

      case "D": {  print("Poor"); }
      break;

      default: {  response = await http.get(
          'https://newsapi.org/v2/top-headlines?country=ar&apiKey=7f8dbc4d1d0046348b76408c8bd5dd52'); }
      break;
    }

       print(response.toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      Map<String, dynamic> map = json.decode(response.body);

      List<dynamic> data = map["articles"];

      for (var u in data) {

        Album user = Album(u["title"], u["description"], u["name"], u["urlToImage"],u["url"],u["publishedAt"]);
        users.add(user);

      }

      print(users.);

      return  users;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }


  int _doudlepress(int std) {
    print("nsghajk");
    setState(() {
     // liked== true;
      DateTime today = new DateTime.now();
     print(today.subtract(Duration(days: 7, hours: 3, minutes: 43,) ));
      print("fjdsufhdskfg");
    });
  }

  String _dateandtime( String i) {
      final int now = DateTime.now().hour;
      print(now);
    int day =int.parse(i.substring(5,7));
    int hour =int.parse(i.substring(11,13));
    print(hour);
    int minute =int.parse(i.substring(14,16));
      int hours= now-hour;
      print(hours);
return hours.toString();
  }

  void searchengine() {
    List<Album> _contacts = [];
    _contacts.addAll(users);
    if (searchcontroller.text.isNotEmpty) {
      _contacts.retainWhere((users) {
        String searchTerm = searchcontroller.text.toLowerCase();
        String contactName = users.titl.toLowerCase();
        return contactName.contains(searchTerm);
      });
      setState(() {
        users = _contacts;

      });
    }
  }

  void _showalertDialog() {
     TextEditingController _controller =new TextEditingController();
    bool text=false;
    var submit="submit";
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
            actionsPadding: EdgeInsets.only(bottom: 10.0,right: 10.0),

            title: new Text("Please Tell Us How To Improve !",
            style: TextStyle(fontWeight:      FontWeight.w900 ) ,
            textAlign: TextAlign.start,),
            content: new TextField(
              onTap: (){
                setState(() {
                  print("mdvab");
                  text=true;
                });

              },
              controller: _controller,
              showCursor: true,

              cursorColor: Colors.black,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "message.....",
                enabledBorder:OutlineInputBorder(
                  borderSide: BorderSide(

                  ),

                ) ,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black87
                  ),
                  borderRadius: BorderRadius.circular(10),
                )


              ),
            ),

            actions: <Widget>[
              SizedBox(
                width: 100.0,
                height: 50.0,
                child: RaisedButton(
                  child: Text('Close'),
                  color: Colors.deepPurpleAccent,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),

              SizedBox(
                width: 100.0,
                height: 50.0,
                child: RaisedButton(
                  child: Text(submit),
                  color: Colors.deepPurpleAccent,
                  onPressed: () {

                    print("fjdsjflsdlfk");
                    FirebaseFirestore.instance
                        .collection('data')
                        .add({'feedback': _controller.text});

                    Timer(Duration(seconds: 3), () {
                      _controller.clear();
                      print("Yeah, this line is printed after 3 seconds");
                    });


                  },
                ),
              )
            ],
          ));

  }

}
class DetailPage extends StatelessWidget {

  final Album user;

  DetailPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('newzapp')),

        body:WebView(
          initialUrl: user.url,
          onPageFinished: _stop(),
          onPageStarted: _loading(),

        )
    );

  }

  _loading() {
    CircularProgressIndicator(
      backgroundColor: Colors.black54,
    );
  }

  _stop() {

  }
}


class  Album
{
  final String titl;
  final String description;
  final String name;
  final String urlToImage ;
  final String url;
  final String  publishedAt;


  Album(this.titl, this.description, this.name,this.urlToImage,this.url,this.publishedAt);

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();

    map['title'] = titl;
    map['description'] = description;
    map['urlToImage'] = urlToImage;
    map['url'] = url;

    return map;
  }
}

