import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:personal_finance_tracker/utils/app_color.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with TickerProviderStateMixin {
  final CollectionReference _transaction =
      FirebaseFirestore.instance.collection("transaction");

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
              "History",
              style: TextStyle(color: AppColor().white),
            ),
            Icon(
              Icons.history_outlined,
              color: AppColor().white,
              size: 30,
            )
          ],
        ),
      ),
      body: StreamBuilder(
          stream: _transaction.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapShot) {
            if (snapShot.hasData) {
              return ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: snapShot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        snapShot.data!.docs[index];
                    Timestamp time = documentSnapshot['dateNtime'];
                    DateTime dateTime =
                        DateTime.parse(time.toDate().toString());

                    return Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      padding: EdgeInsets.only(left: 15, right: 15),
                      width: double.infinity,
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                documentSnapshot['TransactionName'],
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                '${DateFormat('yMMMd').format(dateTime)} at ${DateFormat('jm').format(dateTime)}',
                                style: TextStyle(color: AppColor().darkgrey),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                documentSnapshot['amount'].toString(),
                                style: TextStyle(fontSize: 17),
                              ),
                              (documentSnapshot['amount'] < 0)
                                  ? Icon(
                                      Icons.arrow_outward,
                                      color: AppColor().red,
                                    )
                                  : Transform.rotate(
                                      angle: 180 * math.pi / 180,
                                      child: Icon(
                                        Icons.arrow_outward,
                                        color: AppColor().green,
                                      ))
                            ],
                          )
                        ],
                      ),
                    );
                
                  });
            } else {
              return Center(
                child: Expanded(
                    child: SpinKitFadingCircle(
                  color: AppColor().voilet,
                  size: 50,
                  controller: AnimationController(
                      vsync: this,
                      duration: const Duration(milliseconds: 1000)),
                )),
              );
            }
          }),
    );
  }
}
