import 'package:deliveryboy_app/pages/homepage.dart';
import 'package:deliveryboy_app/pages/notificationpage.dart';
import 'package:deliveryboy_app/pages/orderpage.dart';
import 'package:deliveryboy_app/pages/profilepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  PersistentTabController _controller;

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,

      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),

      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),

      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return [
      HomePage(),
      OrderPage(),
      NotificationPage(),
      ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_outlined),
        title: ("Home"),
        activeColorPrimary: Color(0xffFE0007),
        inactiveColorPrimary: Colors.black,
        textStyle: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 10,
        ),
        iconSize: 25,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.timelapse),
        title: ("Order"),
        textStyle: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 10,
        ),
        iconSize: 25,
        activeColorPrimary: Color(0xffFE0007),
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.notifications_none_outlined),
        title: ("Notification"),
        textStyle: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 10,
        ),
        iconSize: 25,
        activeColorPrimary: Color(0xffFE0007),
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person_outline_rounded),
        title: ("Profile"),
        textStyle: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 10,
        ),
        iconSize: 25,
        activeColorPrimary: Color(0xffFE0007),
        inactiveColorPrimary: Colors.black,
      ),
    ];
  }
}
