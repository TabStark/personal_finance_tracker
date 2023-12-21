import 'dart:async';
import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/utils/app_color.dart';

// ignore: must_be_immutable
class DonePage extends StatefulWidget {
  String message;
  String statusMessage;

  DonePage({super.key, required this.message, required this.statusMessage});

  @override
  State<DonePage> createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  bool showArrow = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2)).then((_) {
      setState(() {
        showArrow = true; //goes back to arrow Icon
        // Anything else you want
      });
    });

    Future.delayed(const Duration(seconds: 7), () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
 
    Loading() {
      return Center(
        child: CircularProgressIndicator(color: AppColor().yellow),
      );
    }

    doneSection() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.message,
            style: TextStyle(color: AppColor().white, fontSize: 25),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.statusMessage,
            style: TextStyle(color: AppColor().white, fontSize: 20),
          ),
          Icon(
            Icons.verified_rounded,
            size: 75,
            color: AppColor().yellow,
          )
        ],
      );
    }

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColor().blue,
        child: showArrow ? doneSection() : Loading(),
      ),
    );
  }
}
