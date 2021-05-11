
import 'package:flutter/material.dart';
import 'package:newz_app/CounterBloc.dart';
import 'package:provider/provider.dart';
void main(){
  runApp(cheakchip());
}
class cheakchip  extends StatefulWidget {

  _State createState() => _State();
}
class _State extends State<cheakchip> {

  final _scoffoldkey = GlobalKey<ScaffoldState>();
  List<String> search =[];
  List<String> list=['india', 'Argentina', 'austrailia',
    'Belgium', 'Brazil', 'china',
    'canada', 'Travel', 'Food', 'Tech',
    'science',
  ];
  int _value;
  bool button=false;
  bool ontap=false;
  bool boolean=true;
  String string="default";
  TextEditingController searchcontroller = new TextEditingController();
  List<int> value =List.filled(12, 0, growable: true);
  CounterBloc provider;

  @override
  Widget build(BuildContext context) {

    provider =  Provider.of<CounterBloc>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: ontap?false:true,

          title: Theme(
            data: ThemeData.light(),

        child: Container(

           decoration:  BoxDecoration(
               borderRadius: BorderRadius.circular(10),
           color: Colors.white),
          height: 45,
          width: 350,
          margin: EdgeInsets.all(5),
          child: TextField(
            autofocus: false,

           controller: searchcontroller,
            onTap: (){
              setState(() {
                ontap=true;
                searchcontroller.addListener(() {
                  filterContacts();
                });
              });
            },
            autocorrect: true,
            style: TextStyle(color: Colors.blueGrey),
            cursorColor: Colors.grey,

            decoration: InputDecoration(
              disabledBorder:new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.blue)
              ) ,
              prefixIcon: Icon(Icons.search,color: Colors.blueGrey,),
                border: InputBorder.none,
              hintText: 'search country',
              hintStyle: TextStyle(color: Colors.grey)


            ),
          ),
        ),
      )


      ),
      key: _scoffoldkey,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(95, 12, 95, 12),
                disabledColor: Colors.black54,
                color: button?Colors.red:Colors.black54,
                onPressed: (){
                            print("djadshfjka");
                           print(string);
                        provider.setString(string);
                            if(string=='default') {
                              final snackbar = SnackBar(
                                margin: EdgeInsets.only(bottom: 17,left: 10,right: 10),

                                content: Text("please select one!"),
                                behavior: SnackBarBehavior.floating,
                                duration: Duration(seconds: 5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius
                                        .circular(10))),
                                action: SnackBarAction(
                                  label: 'undo',
                                  onPressed: () {
                                    _scoffoldkey.currentState
                                        .hideCurrentSnackBar();
                                  },
                                ),
                  );
                              print("dfadsh");
                              _scoffoldkey.currentState.showSnackBar(snackbar);
                            }
                  },
                animationDuration:Duration(
                    seconds: 1
                ) ,
                child: Text("select counrty"
                  ,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ) ,
                ),
                textColor: Colors.white,

              ),
            ),
          ),

           Expanded(
             child: SingleChildScrollView(
                   scrollDirection: Axis.vertical,
               child: Wrap(
                children: List<Widget>.generate( search.isEmpty?list.length:search.length
                  ,
                      (int index) {
                    return Padding(
                      padding: EdgeInsets.all(5),
                      child: ChoiceChip(
                        padding: EdgeInsets.all(10),

                        avatar:  value[index]==1?Center(child: Icon(Icons.assignment_turned_in_rounded,color: Colors.white,size: 20,)):CircleAvatar(backgroundColor: Colors.black54, child:Text(list[index].substring(0,1), style: TextStyle(color: Colors.white))),
                        label: Text(search.isEmpty?list[index]:search[index], style: TextStyle(color: Colors.white)),
                        selected: _value == index,
                        selectedColor: Colors.red ,
                        onSelected: (bool selected) {
                          setState(() {
                            print("fglkfhg");
                            _value = selected ? index : null;
                            value.fillRange(0, 12,0);
                            if(selected){
                              button=true;
                              boolean=selected;
                              string=search.isEmpty?list[index]:search[index];
                              return value[index]=1;
                            }
                            button=false;
                            return value[index]=0;


                          });
                        },
                      ),
                    );
                  },
                ).toList(),
        ),
             ),
           ),

  ]
      ),
    );
  }

  void filterContacts() {
     {
       print("kfgd");
      List<String> _contacts = [];
      _contacts.addAll(list);
      if (searchcontroller.text.isNotEmpty) {
        _contacts.retainWhere((list) {
          String searchTerm = searchcontroller.text.toLowerCase();
          return list.contains(searchTerm);
        });
        setState(() {
          print("'dfjah");

          search = _contacts;
          print(search);
        });
      }else{
        setState(() {
          search=list;
        });

        print("hjkgahjf");
      }
    }
  }
}
