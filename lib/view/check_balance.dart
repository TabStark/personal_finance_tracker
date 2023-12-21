import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/utils/app_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckBalance extends StatefulWidget {
  const CheckBalance({super.key});

  @override
  State<CheckBalance> createState() => _CheckBalanceState();
}

class _CheckBalanceState extends State<CheckBalance> {
  num totalSum = 0;
  bool view = true;

  Future<void> _calculateSum() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("transaction").get();

    num sum = 0;
    querySnapshot.docs.forEach((element) {
      sum += element['amount'] ?? 0;
    });

    setState(() {
      totalSum = sum;
      view = !view;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [AppColor().purple, AppColor().midpurple]))),
          backgroundColor: AppColor().purple,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Check Balance",
                style: TextStyle(color: AppColor().white),
              ),
              Icon(
                Icons.account_balance_outlined,
                color: AppColor().white,
                size: 30,
              )
            ],
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              view ? "*****" : "₹${totalSum.toString()}",
              style: TextStyle(color: AppColor().black, fontSize: 30),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () => _calculateSum(),
              child: Container(
                child: Text(view ? "View" : "Hide",
                    style: TextStyle(color: AppColor().blue, fontSize: 20)),
              ),
            )
          ]),
        ));
  }
}
