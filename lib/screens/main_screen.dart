import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/components/constants.dart';
import 'package:shopping_app/screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget? _child;

  @override
  void initState() {
    _child = const HomeScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _child,
        bottomNavigationBar: FluidNavBar(
          icons: [
            FluidNavBarIcon(
                icon: Icons.home_filled,
                backgroundColor: kPrimaryColor,
                extras: {"label": "home"}),
            FluidNavBarIcon(
                icon: Icons.menu,
                backgroundColor:  kPrimaryColor,
                extras: {"label": "categories"}),
            FluidNavBarIcon(
                icon: Icons.shopping_cart,
                backgroundColor: kPrimaryColor,
                extras: {"label": "cart"}),
            FluidNavBarIcon(
                icon: Icons.person,
                backgroundColor: kPrimaryColor,
                extras: {"label": "account"}),
          ],
          onChange: _handleNavigationChange,
          style: const FluidNavBarStyle(iconUnselectedForegroundColor: Colors.white, iconSelectedForegroundColor: Colors.white, barBackgroundColor: kPrimaryColor, ),
          scaleFactor: 1.5,
          defaultIndex: 0,
          itemBuilder: (icon, item) => Semantics(
            label: icon.extras!["label"],
            child: item,
          ),
        ),
      ),
    );
  }
  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = HomeScreen();
          break;
        case 1:
          _child = HomeScreen();
          break;
        case 2:
          _child = HomeScreen();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: const Duration(milliseconds: 300),
        child: _child,
      );
    });
  }
}
