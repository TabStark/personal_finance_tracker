import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:personal_finance_tracker/utils/app_color.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:math' as math;

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> with TickerProviderStateMixin {
  final scrollController = ScrollController();
  double totalIncome = 0;
  double totalExpences = 0;
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CollectionReference _transaction =
        FirebaseFirestore.instance.collection("transaction");

    Future<void> incomeAndExpenses() async {
      QuerySnapshot querySnapshot = await _transaction.get();
      num incomeSum = 0;
      num expencesSum = 0;
      querySnapshot.docs.forEach((element) {
        if (element['amount'] < 0) {
          expencesSum += element['amount'];
        } else {
          incomeSum += element['amount'];
        }
      });
      setState(() {
        totalIncome = incomeSum.toDouble() + expencesSum.toDouble();
        totalExpences = 0 - expencesSum.toDouble();
      });
    }

    incomeAndExpenses();
    final ColorList = <Color>[
      AppColor().lightpurple,
      AppColor().maxlightpurple,
    ];
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
                "Hiii Tabrez,",
                style: TextStyle(color: AppColor().white),
              ),
              FaIcon(
                FontAwesomeIcons.bell,
                color: AppColor().white,
              )
            ],
          ),
        ),
        body: StreamBuilder(
            stream: _transaction.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapShot) {
              if (!snapShot.hasData) {
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
              } else {
                return CustomScrollView(
                  physics: ClampingScrollPhysics(),
                  controller: scrollController,
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      pinned: true,
                      expandedHeight: 350,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.height * 0.37,
                              child: TextField(
                                controller: _searchController,
                                onChanged: ((value) {
                                  setState(() {
                                    print(value);
                                  });
                                }),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Search",
                                  suffixIcon: Icon(Icons.search),
                                  contentPadding: EdgeInsets.only(left: 15),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColor().darkgrey,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor().voilet),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                ),
                              )),
                          CircleAvatar(
                            radius: 23,
                            backgroundColor: AppColor().voilet,
                            child: const CircleAvatar(
                              radius: 22,
                              backgroundImage: AssetImage(
                                "assets/images/user.png",
                              ),
                            ),
                          )
                        ],
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                          background: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                              AppColor().purple,
                              AppColor().midpurple
                            ])),
                        height: 250,
                        width: double.infinity,
                        child: PieChart(
                          dataMap: {
                            "Income": totalIncome,
                            "Expences": totalExpences,
                          },
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          colorList: ColorList,
                          chartType: ChartType.ring,
                          chartRadius: MediaQuery.of(context).size.width / 2.8,
                          animationDuration: const Duration(milliseconds: 1200),
                          legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left,
                              legendTextStyle: TextStyle(
                                  fontSize: 16, color: AppColor().white)),
                        ),
                      )),
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(34),
                        child: Container(
                          height: 35,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColor().white,
                              border: Border(
                                top: BorderSide(
                                    color: AppColor().lightgrey, width: 5),
                              ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Center(
                              child: Icon(
                            Icons.remove,
                            size: 50,
                            color: AppColor().lightgrey,
                          )),
                        ),
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final reversedIndex =
                            snapShot.data!.docs.length - index - 1;
                        final List<QueryDocumentSnapshot<Object?>>
                            documentSnapshot = snapShot.data!.docs;
                        Timestamp time =
                            documentSnapshot[reversedIndex]['dateNtime'];
                        DateTime dateTime =
                            DateTime.parse(time.toDate().toString());
                        String transactionName =
                            documentSnapshot[reversedIndex]['TransactionName'];
                        if (_searchController.text.isEmpty) {
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
                                      documentSnapshot[reversedIndex]
                                          ['TransactionName'],
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      '${DateFormat('yMMMd').format(dateTime)} at ${DateFormat('jm').format(dateTime)}',
                                      style:
                                          TextStyle(color: AppColor().darkgrey),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      documentSnapshot[reversedIndex]['amount']
                                          .toString(),
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    (documentSnapshot[reversedIndex]['amount'] <
                                            0)
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
                        } else if (transactionName
                            .toLowerCase()
                            .contains(_searchController.text.toLowerCase())) {
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
                                      documentSnapshot[reversedIndex]
                                          ['TransactionName'],
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      '${DateFormat('yMMMd').format(dateTime)} at ${DateFormat('jm').format(dateTime)}',
                                      style:
                                          TextStyle(color: AppColor().darkgrey),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      documentSnapshot[reversedIndex]['amount']
                                          .toString(),
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    (documentSnapshot[reversedIndex]['amount'] <
                                            0)
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
                        } else {
                          return Container();
                        }
                      },
                      childCount: snapShot.data!.docs.length,
                    ))
                  ],
                );
              }
            }));
  }
}
