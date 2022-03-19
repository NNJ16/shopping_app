import 'package:flutter/material.dart';
import 'package:shopping_app/components/constants.dart';
import 'package:shopping_app/components/dashboard_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16,top : 16),
          child: Row(
            children: const [
              DashboardCard(icon: Icons.bar_chart, color: Colors.red, tittle: "Total Sales", subTitle: "Rs. 5000.00",),
              SizedBox(
                width: 8,
              ),
              DashboardCard(icon: Icons.group, color: Colors.amber, tittle: "Total Customers", subTitle: "20",),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16,top : 8),
          child: Row(
            children: const [
              DashboardCard(icon: Icons.category, color: Colors.teal, tittle: "Total Products", subTitle: "15",),
              SizedBox(
                width: 8,
              ),
              DashboardCard(icon: Icons.device_hub, color: Colors.blue, tittle: "Total Suppliers", subTitle: "10",),
            ],
          ),
        )
      ],
    );
  }
}
