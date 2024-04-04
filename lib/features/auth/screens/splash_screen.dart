import 'package:application_for_restaurants/core/globals.dart';
import 'package:application_for_restaurants/features/auth/screens/login_screen.dart';
import 'package:application_for_restaurants/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2),() async {
      SharedPreferences prefs=await SharedPreferences.getInstance();
      String? remembered=prefs.getString('remembered');
      if(remembered==null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage(),));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return const Scaffold(
      body: Center(child: Image(image:AssetImage('assets/images/logo.png')),),
    );
  }
}
