import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_app/data_models/product_preferences.dart';
import 'package:smooth_app/data_models/user_preferences.dart';

import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  _SplashScreenState(){

    Timer(const Duration(milliseconds: 2000), (){
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
          
        MaterialPageRoute<Widget>(builder: (BuildContext context) {
           final UserPreferences userPreferences = context.watch<UserPreferences>();
               final ProductPreferences productPreferences =
        context.watch<ProductPreferences>();
          return LoginPagee(userPreferences: userPreferences,productPreferences:productPreferences);
        }), (Route route) => false);
      });
    });

    Timer(
      const Duration(milliseconds: 10),(){
        setState(() {
          _isVisible = true; // Now it is showing fade effect and navigating to Login page
        });
      }
    );

  }
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Theme.of(context).colorScheme.secondary, Theme.of(context).primaryColor],
          begin: const FractionalOffset(0, 0),
          end: const FractionalOffset(1.0, 0.0),
          stops: const [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0,
        duration: const Duration(milliseconds: 1200),
        child: Center(
          child: Container(
            height: 140.0,
            width: 140.0,
            child: const Center(
              child: ClipOval(
                child: Icon(Icons.android_outlined, size: 128,), //put your logo here
              ),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 2.0,
                  offset: const Offset(5.0, 3.0),
                  spreadRadius: 2.0,
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}