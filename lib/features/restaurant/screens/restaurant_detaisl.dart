import 'package:application_for_restaurants/core/commons/expanded_text.dart';
import 'package:application_for_restaurants/models/data_model.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../core/globals.dart';
class RestaurantDetails extends StatefulWidget {
  final Restaurant restaurant;
  final String restaurantImage;
  const RestaurantDetails({super.key,required this.restaurant,required this.restaurantImage});

  @override
  State<RestaurantDetails> createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  double raiting=0.0;
  getRaiting(){
    var sum=0;
    for(int i=0;i<widget.restaurant.reviews.length;i++){
      sum=sum+widget.restaurant.reviews[i].rating;
    }
    raiting=sum/widget.restaurant.reviews.length;
  }
  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrlString(googleUrl)) {
      await launchUrlString(googleUrl);
    } else {
      throw 'Could not launch $googleUrl';
    }
  }
  String today="";
  List timeKeys=[];
  Map time={};
  String getDayName(DateTime dateTime) {
    // Define a list of day names
    List<String> daysOfWeek = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    // Get the index of the day of the week (0 for Monday, 1 for Tuesday, etc.)
    int dayIndex = dateTime.weekday - 1;

    // Return the day name
    return daysOfWeek[dayIndex];
  }

  String getCorrectTime(String time){
    String result="";
    int c=0;
    int ind=0;
    if(!time.contains(',')){
      for(int i=0;i<time.length;i++){

        if(time[i]=="="){
          ind++;
          result="$result${time.substring(c,i)}:";
          c=i+2;
          if(ind==2){
            result="$result${time.substring(c,time.length)}";
          }
        }

      }
    }
    else{
      for(int i=0;i<time.length;i++){

        if(time[i]=="="){

          result="$result${time.substring(c,i)}:";
          c=i+2;

        }

      }
      result="$result${time.substring(c,time.length)}";
    }


    return result;
  }
  getTime(){
    today=getDayName(DateTime.now());
    time["Sunday"]=getCorrectTime(widget.restaurant.operatingHours.sunday);
    time["Monday"]=getCorrectTime(widget.restaurant.operatingHours.monday);
    time["Tuesday"]=getCorrectTime(widget.restaurant.operatingHours.tuesday);
    time["Wednesday"]=getCorrectTime(widget.restaurant.operatingHours.wednesday);
    time["Thursday"]=getCorrectTime(widget.restaurant.operatingHours.thursday);
    time["Friday"]=getCorrectTime(widget.restaurant.operatingHours.friday);
    time["Saturday"]=getCorrectTime(widget.restaurant.operatingHours.saturday);
    for(var i in time.keys){
      if(i!=today){
        timeKeys.add(i);
      }
    }
  }
  @override
  void initState() {
    getRaiting();
    getTime();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                height: height*0.28,
                width: width,
                child: Image.asset(widget.restaurantImage,fit: BoxFit.cover,)),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal:width*0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: width*0.05,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.restaurant.name,
                        style: TextStyle(
                            fontSize: width * .05,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Container(
                        height: height*0.03,
                        width: width*0.15,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(height*0.015),color: Colors.green),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(raiting.toStringAsFixed(1),style:TextStyle(color: Colors.white),),
                            Icon(Icons.star,color: Colors.white,size: width*0.04,)
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: width*0.05,),
                  Text(
                    widget.restaurant.neighborhood.name,
                    style: TextStyle(
                        fontSize: width * .04,
                        color: Colors.black),
                  ),
                  SizedBox(height: width*0.03,),
                  Row(
                    children: [
                      Icon(Icons.restaurant_menu,color: Colors.grey,),
                      SizedBox(width: 5,),
                      Text(
                        widget.restaurant.cuisineType,
                        style: TextStyle(
                            fontSize: width * .035,
                            color: Colors.black),
                      ),
                    ],
                  ), SizedBox(height: width*0.03,),
                  Row(
                    children: [
                      Icon(Icons.location_on,color: Colors.grey,),
                      SizedBox(width: 5,),
                      Text(
                        widget.restaurant.address,
                        style: TextStyle(
                            fontSize: width * .035,
                            color: Colors.black),
                      ),
                    ],
                  ), SizedBox(height: width*0.03,),
                  SizedBox(height: height*0.005,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ExpandablePanel(
                          collapsed: Container(), expanded: SizedBox(
                            child:Padding(
                              padding:  EdgeInsets.only(left:width*0.06),
                              child: Column(
                                children: List.generate(timeKeys.length, (index) {
                                  return SizedBox(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: width*0.2,
                                                child: Text("${timeKeys[index]}:",style: TextStyle(fontSize: width*0.035),)),
                                            SizedBox(
                                                width: width*0.6,
                                                child: Text("${time[timeKeys[index]]}",style: TextStyle(fontSize: width*0.035),)),
                                          ],
                                        ),
                                        SizedBox(height: height*0.005,),
                                      ],
                                    ));
                                }),
                              ),
                            )

                        ),
                          theme: ExpandableThemeData(
                              iconColor: Colors.black,
                              iconSize: 14,
                              iconPadding: EdgeInsets.only(bottom: height*0.008,right: width*0.05)
                          ),
                          header: SizedBox(
                              height: height*0.02,
                              child: Row(
                                children: [
                                  Icon(Icons.access_time_filled_rounded,color: Colors.grey,size: width*0.05,),
                                  SizedBox(width: width*0.01,),
                                  Text("$today: ${time[today]}",style: TextStyle(fontSize: width*0.035),),
                                ],
                              )),


                        ),
                      ),],
                  ),
                  SizedBox(height: width*0.05 ,),
                  Text(
                    "Rating & Reviews",
                    style: TextStyle(
                        fontSize: width * .05,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  // SizedBox(height: width*0.04,),
                  SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.restaurant.reviews.length,
                      itemBuilder: (context, index) =>  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: height*0.03,
                                width: width*0.15,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(height*0.015),color: Colors.green),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(widget.restaurant.reviews[index].rating.toStringAsFixed(1),style:TextStyle(color: Colors.white),),
                                    Icon(Icons.star,color: Colors.white,size: width*0.04,)
                                  ],
                                ),
                              ),
                              SizedBox(width: 5,),
                              Text(widget.restaurant.reviews[index].name,style:  TextStyle(
                                  fontSize: width * .04,
                                  color: Colors.black),
                           ),
                            ],
                          ),
                          SizedBox(height: height*0.01,),
                           ExpandedText(content:  widget.restaurant.reviews[index].comments),
                          SizedBox(height: height*0.01,),
                          Text(widget.restaurant.reviews[index].date.name
                              .substring(0, 7) +
                              ' ' +
                              widget.restaurant.reviews[index].date.name
                                  .substring(8, 10) +
                              " " +
                              widget.restaurant.reviews[index].date.name
                                  .substring(10).toString(),style: TextStyle(fontSize: width * .03, color: Colors.black),),
                          Divider(thickness: 0.5,color: Colors.grey,)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: height*0.1,)
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          openMap( widget.restaurant.latlng.lat, widget.restaurant.latlng.lng);
        },
        child: CircleAvatar(
          radius: width*0.08,
          backgroundColor: Colors.orange[600],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Icon(Icons.directions_outlined,color: Colors.white,),
          Text('Go',style: TextStyle(fontSize: width * .04,fontWeight: FontWeight.bold, color: Colors.white),)
        ],),),
      ),
    );
  }
}
