import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/components/constants.dart';
import 'package:shopping_app/dto/item_dto.dart';
import 'package:shopping_app/screens/account_screen.dart';
import 'package:shopping_app/screens/order_screen.dart';
import 'package:shopping_app/screens/cart_screen.dart';
import 'package:shopping_app/screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  int _noOfItems = 0;
  final _cartItemList = <ItemDTO>[];
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> _children() => [
        HomeScreen(
          callBack: updateCart,
          user: widget.user,
        ),
        OrderScreen(user: widget.user,),
        CartSreen(
          navigateToHome: navigateToHome,
          cartItemList: _cartItemList,
          callBack: deleteCart,
          user: widget.user,
        ),
        const AccountScreen()
      ];

  @override
  void initState() {
    super.initState();
  }

  updateCart(ItemDTO itemDTO) {
    _cartItemList.add(itemDTO);
    setState(() {
      _noOfItems = _cartItemList.length;
    });
  }

  deleteCart() async{
    setState(() {
      _cartItemList.clear();
      _noOfItems = 0;
    });
  }
  
  navigateToHome() async{
    setState(() {
      _selectedIndex = 0;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = _children();
    return SafeArea(
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Badge(
                elevation: 0,
                position: BadgePosition.topEnd(top: -8, end: -4),
                badgeContent: Text(
                  _noOfItems.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 8),
                ),
                child: const Icon(Icons.shopping_cart),
              ),
              label: 'Cart',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
            ),
          ],
          currentIndex: _selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.amber[600],
          unselectedItemColor: kSecondaryColor,
          backgroundColor: kPrimaryColor,
          iconSize: 24,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
