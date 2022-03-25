import 'package:flutter/material.dart';
import 'package:shopping_app/components/constants.dart';
import 'package:shopping_app/screens/admin/item/add_item.dart';
import 'dashboard_screen.dart';
import 'item/item_screen.dart';
import 'order/order_screen.dart';
import 'supplier/supplier_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _selectedIndex = 0;
  String _title = "Dashboard";

  static const List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    OrderScreen(),
    ItemScreen(),
    SupplierScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        backgroundColor: kPrimaryColor,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: kPrimaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/profile.png'),
                      radius: 30,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      "Robert Steve",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.0,
                    ),
                    child: Text("roberts@gmail.com",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(
                    Icons.dashboard,
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Dashboard')
                ],
              ),
              onTap: () {
                setState(() {
                  _title = "Dashboard";
                  _selectedIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(
                    Icons.menu,
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Orders')
                ],
              ),
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                  _title = "Orders";
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(
                    Icons.category,
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Items')
                ],
              ),
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                  _title = "Items";
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(
                    Icons.device_hub,
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Suppliers')
                ],
              ),
              onTap: () {
                setState(() {
                  _selectedIndex = 3;
                  _title = "Suppliers";
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(
                    Icons.exit_to_app,
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Logout')
                ],
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
