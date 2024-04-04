import 'package:application_for_restaurants/features/auth/controller/auth_controller.dart';
import 'package:application_for_restaurants/features/restaurant/screens/restaurant_detaisl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/globals.dart';
import '../controller/home_controller.dart';
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    List<String> images=[
      'assets/images/res5.jpg',
      'assets/images/res1.jpg',
      'assets/images/res2.jpg',
      'assets/images/res3.jpg',
      'assets/images/res4.jpg',
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange,
        title:Text(
          "RESTAURANTS",
          style: TextStyle(
              fontSize: width * .05,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: width*0.08),
            child: InkWell(
              onTap: () {
                showDialog(context: context, builder: (context) => AlertDialog(
                  title: Text('Are you sure You want to logout'),
                  actions: [
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: Text('cancel')),TextButton(onPressed: () {
                      Navigator.pop(context);
                      ref.read(authControllerProvider.notifier).userLogOut(context: context);
                    }, child: Text('yes')),
                  ],
                ),);
              },
              child: Row(
                children: [
                  Icon(Icons.logout_sharp,size: width*0.05,),
                  SizedBox(width: 5,),
                  Text('Logout',style:TextStyle(
                      fontSize: width * .03,
                      color: Colors.white))
                ],
              ),
            ),
          )
        ],
      ),
      body: Consumer(
        builder: (context,ref,child) {
          return ref.watch(restaurantsProvider).when(data: (data) {
            return ListView.builder(padding:EdgeInsets.symmetric(vertical: 5),
              physics: BouncingScrollPhysics(),
              itemCount: data.restaurants.length,
              itemBuilder:(context, index) {
                double raiting=0.0;
                var sum=0;
                for(int i=0;i<data.restaurants[index].reviews.length;i++){
                  sum=sum+data.restaurants[index].reviews[i].rating;
                }
                raiting=sum/data.restaurants[index].reviews.length;
                return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantDetails(restaurant: data.restaurants[index],restaurantImage:images[index%5],),));
                },
                child: Card(
                  elevation: 30,
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(width*0.2)),
                    height: height*0.38,
                    child: Column(
                      children: [
                        SizedBox(
                            height: height*0.25,
                            width: width,
                            child: Image.asset(images[index%5],fit: BoxFit.cover,)),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: width*0.06),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(height: height*0.02,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data.restaurants[index].name,
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
                                        Text(raiting.toStringAsFixed(1).toString(),style:TextStyle(color: Colors.white),),
                                        Icon(Icons.star,color: Colors.white,size: width*0.04,)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: height*0.02,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(Icons.restaurant_menu,color: Colors.grey,),
                                  SizedBox(width: 5,),
                                  Text(data.restaurants[index].cuisineType)
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_on,color: Colors.grey,),
                                  SizedBox(width: 5,),
                                  Text(data.restaurants[index].address)
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
              }, );
          }, error:(error, stackTrace) => Text('Error: ${error.toString()}',style: TextStyle(color:Colors.red,backgroundColor:Colors.yellow)), loading:() =>  CircularProgressIndicator());
      }
      ),
    );
  }
}
