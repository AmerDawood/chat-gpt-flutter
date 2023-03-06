import 'package:chat_gpt/services/assets_manager.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState(){
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
      // String routeName =UserPreferenceController().loggedIn?'/app_screen':'/manOrWoman';
      Navigator.pushReplacementNamed(context, '/cart_screen');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              AssetsManager.botImage,
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}


