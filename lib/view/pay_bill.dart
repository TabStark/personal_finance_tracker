import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/utils/app_color.dart';
import 'package:personal_finance_tracker/view/done_page.dart';
import 'package:personal_finance_tracker/viewmodal/firebase_backend.dart';

class PayBills extends StatefulWidget {
  const PayBills({super.key});

  @override
  State<PayBills> createState() => _PayBillsState();
}

class _PayBillsState extends State<PayBills> {
  TextEditingController _amount = TextEditingController();
  TextEditingController _notes = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _amount.dispose();
    _notes.dispose();
  }

  bool isButtonActive = false;

  onChangeFunction() {
    if (_amount.text.isEmpty || _notes.text.isEmpty) {
      setState(() {
        isButtonActive = false;
      });
    } else {
      setState(() {
        isButtonActive = true;
      });
    }
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
              "Pay Bills",
              style: TextStyle(color: AppColor().white),
            ),
            Icon(
              Icons.payment_outlined,
              color: AppColor().white,
              size: 30,
            )
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 100),
        width: double.infinity,
        height: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Enter Amount",
              style: TextStyle(color: AppColor().darkgrey, fontSize: 30),
            ),
            Container(
              width: 100,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor().maxlightgrey,
              ),
              constraints: const BoxConstraints(minWidth: 150, maxWidth: 300),
              child: Center(
                child: TextField(
                  onChanged: ((value) {
                    onChangeFunction();
                  }),
                  controller: _amount,
                  style: TextStyle(fontSize: 25),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  decoration:
                      InputDecoration(hintText: "₹", border: InputBorder.none),
                ),
              ),
            ),
            Container(
              width: 200,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor().maxlightgrey,
              ),
              constraints: const BoxConstraints(minWidth: 150, maxWidth: 300),
              child: Center(
                child: TextField(
                  onChanged: ((value) {
                    onChangeFunction();
                  }),
                  controller: _notes,
                  style: TextStyle(fontSize: 18),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: 'Enter Notes', border: InputBorder.none),
                ),
              ),
            ),
            Container(
              width: 150,
              height: 50,
              child: ElevatedButton(
                onPressed: isButtonActive
                    ? () async {
                        String sendAmount = _amount.text;
                        bool status = await FireBaseStoreData()
                            .updateData(_notes.text, "-${sendAmount}");
                        String message = _notes.text;

                        if (status) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DonePage(
                                        message: message,
                                        statusMessage: "Successfully Paid",
                                      )));
                          _notes.text = "";
                          _amount.text = "";
                        }
                      }
                    : null,
                child: Text(
                  "PAY",
                  style: TextStyle(color: AppColor().white, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                    onSurface: AppColor().purple,
                    backgroundColor: AppColor().purple),
              ),
            )
          ],
        ),
      ),
    );
  }
}
