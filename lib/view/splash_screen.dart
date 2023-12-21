import 'dart:async';
import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/utils/app_color.dart';
import 'package:personal_finance_tracker/view/home_pages.dart';
import 'package:typethis/typethis.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this)
          ..forward();
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor().voilet,
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                child: Container(
                  height: 150,
                  width: 150,
                  child: Image.asset('assets/images/log.png'),
                ),
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi,
                    child: child,
                  );
                },
              ),
              TypeThis(
                string: "Money Tracker",
                speed: 200,
                style: TextStyle(
                    color: AppColor().white,
                    fontSize: 30,
                    fontFamily: "Bernadette"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
