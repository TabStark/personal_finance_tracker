import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:personal_finance_tracker/utils/app_color.dart';
import 'package:personal_finance_tracker/view/add_to_wallet.dart';
import 'package:personal_finance_tracker/view/dashboard.dart';
import 'package:personal_finance_tracker/view/history_page.dart';
import 'package:personal_finance_tracker/view/password_verification.dart';
import 'package:personal_finance_tracker/view/pay_bill.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreen() {
    return [
      DashBoard(),
      AddtoWallet(),
      PayBills(),
      HistoryPage(),
      PasswordVerification()
    ];
  }

  List<PersistentBottomNavBarItem> _navigationItem() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_outlined),
        title: "Home",
        activeColorPrimary: AppColor().voilet,
        inactiveColorPrimary: AppColor().darkgrey,
      ),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.account_balance_wallet_outlined),
          title: "Add to wallet",
          activeColorPrimary: AppColor().voilet,
          inactiveColorPrimary: AppColor().darkgrey),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.payment_outlined),
          title: 'Pay Bill',
          activeColorPrimary: AppColor().voilet,
          inactiveColorPrimary: AppColor().darkgrey),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.history_outlined),
          title: 'History',
          activeColorPrimary: AppColor().voilet,
          inactiveColorPrimary: AppColor().darkgrey),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.account_balance_outlined),
          title: 'Check Balance',
          activeColorPrimary: AppColor().voilet,
          inactiveColorPrimary: AppColor().darkgrey)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreen(),
      items: _navigationItem(),
      controller: _controller,
      decoration: NavBarDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          border: Border(
              top: BorderSide(color: AppColor().voilet),
              left: BorderSide(color: AppColor().voilet),
              right: BorderSide(color: AppColor().voilet))),
      navBarStyle: NavBarStyle.style3,
    );
  }
}
