import 'package:flutter/material.dart';
import 'package:newz_app/cheakchip.dart';
import 'package:newz_app/setting.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<SliderModel> slides = new List<SliderModel>();
  int currentIndex = 0;
  PageController _controller;
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
    slides = getSlides();
  }
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Column(
            children: [
         Expanded(
           flex: 8,
           child: PageView.builder(
           scrollDirection: Axis.horizontal,
               onPageChanged: (value){
                 setState(() {
                   currentIndex = value;
                 });
               },
               itemCount: slides.length,
               itemBuilder: (context, index){

                 // Contents of Slider that we
                 // created in Modal Class
                 return Slider(
                   image: slides[index].getImage(),
                   title: slides[index].getTitle(),
                   description: slides[index].getDescription(),
                 );
               }
           ),
         ),

    // Container created for dots

                  Expanded(
                    flex: 1,
                    child: Container(

    child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(slides.length, (index) => buildDot(index, context),
    ),
    ),
    ),
                  ),


              Container(
                height: 60,
                margin: EdgeInsets.only(left: 20,top: 5,bottom: 20,right: 20,),
                width: double.infinity,
                color: Colors.deepPurpleAccent.withOpacity(0.8),
                // Button
                child: FlatButton(
                  child: Text(
                      currentIndex == slides.length - 1 ? "Continue": "Next"),
                  onPressed: (){
                    if(currentIndex == slides.length - 1){
                          print("dfkjahkjah");
                      // Navigate to next screen
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>cheakchip()),
                      );
                    }
                    _controller.nextPage(duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
                  },
                  textColor: Colors.white,

                  // Border radius to button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),

              ),

            ]
    ),

    );
    }
  Container buildDot(int index, BuildContext context){
// Another Container returned
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.deepPurple,
      ),
    );
  }
}

class Slider extends StatelessWidget {
  String image,title,description;

//Constructor created
  Slider({this.image, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(

      // column containing image
      // title and description
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Image(image: AssetImage(image)),
          ),
          SizedBox(height: 10),
          Text(title, style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize:14 ),),
          ),

        ],
      ),
    );
  }
}

  class SliderModel{
  String image;
  String title;
  String description;


// Constructor for variables
  SliderModel({this.title, this.description, this.image});

  void setImage(String getImage){
  image = getImage;
  }

  void setTitle(String getTitle){
  title = getTitle;
  }
  void setDescription(String getDescription){
  description = getDescription;
  }

  String getImage(){
  return image;
  }

  String getTitle(){
  return title;
  }
  String getDescription(){
  return description;
  }
  }

// List created
  List<SliderModel> getSlides(){
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

// Item 1
  sliderModel.setImage("assets/social_share.svg.png");
  sliderModel.setTitle("Share On Social Media  ");
  sliderModel.setDescription("On one Tap to share on whatsapp,Telegram,instagram and so on ");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

// Item 2
  sliderModel.setImage("assets/one_notifiation.svg.png");
  sliderModel.setTitle("One Notification On A Day");
  sliderModel.setDescription(" Set a time and receive your newz just when you want it. \none nottification,No spam");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

// Item 3
  sliderModel.setImage("assets/language.png");
  sliderModel.setTitle(" Read On Multiple Languages");
  sliderModel.setDescription(" Read newz from the diffrent diffrent country available more than 15 language just you need to chooose country you can change it later also ");
  slides.add(sliderModel);

  sliderModel = new SliderModel();
  return slides;
  }

