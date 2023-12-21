import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_finance_tracker/utils/app_color.dart';
import 'package:personal_finance_tracker/view/check_balance.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PasswordVerification extends StatefulWidget {
  const PasswordVerification({super.key});

  @override
  State<PasswordVerification> createState() => _PasswordVerificationState();
}

class _PasswordVerificationState extends State<PasswordVerification> {
  TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
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
              "Password Verification",
              style: TextStyle(color: AppColor().white),
            ),
            Icon(
              Icons.password,
              color: AppColor().white,
              size: 30,
            )
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 200, left: 20, right: 20),
        height: double.infinity,
        width: double.infinity,
        color: AppColor().white,
        child: Column(
          children: [
            Text(
              "Enter the Pin",
              style: TextStyle(color: AppColor().voilet, fontSize: 20),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              child: PinCodeTextField(
                controller: _controller,
                enabled: true,
                appContext: context,
                length: 6,
                enableActiveFill: true,
                textStyle: TextStyle(fontSize: 20, color: AppColor().white),
                cursorHeight: 19,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  fieldWidth: 50,
                  inactiveColor: AppColor().voilet,
                  selectedColor: AppColor().midpurple,
                  activeFillColor: AppColor().midpurple,
                  selectedFillColor: AppColor().midpurple,
                  inactiveFillColor: AppColor().white,
                  borderWidth: 1,
                  borderRadius: BorderRadius.circular(8),
                ),
                onChanged: ((value) {
                  print(value);
                }),
              ),
            ),
            InkWell(
              onTap: () {
                if (_controller.text == "123456") {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CheckBalance()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Incorrect Password")));
                }
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Center(
                    child: Text(
                  "Verify",
                  style: TextStyle(color: AppColor().white, fontSize: 20),
                )),
                decoration: BoxDecoration(
                    color: AppColor().midpurple,
                    borderRadius: BorderRadius.circular(10)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
