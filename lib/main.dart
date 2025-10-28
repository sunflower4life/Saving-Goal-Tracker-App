import 'package:flutter/material.dart';
import 'sgtCalcScreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget { //no changes
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget { //changes in ui
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration (seconds: 2),(){
      Navigator.pushReplacement( //navigate to the SGTCalcScreen
        context,
        MaterialPageRoute(builder: (context) => const SGTCalcScreen()), //navigate to home after navigator.pushreplacement
    );
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( //center to make sure all content stays in the middle of screen
        child: Column( //arrange item vertically
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/saving goal.png" , scale: 3.0, ), //"C:\FlutterProject\saving goalr.png"
            CircularProgressIndicator(),
            SizedBox(height:20),
            Text('Loading'),
          ],
        ),
      ),
    );
  }
}
