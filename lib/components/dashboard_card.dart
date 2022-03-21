import 'package:flutter/material.dart';
import 'package:shopping_app/components/constants.dart';

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String tittle;
  final String subTitle;
  final Color color;

  const DashboardCard({Key? key, required this.icon, required this.tittle, required this.subTitle, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              subTitle,
              style:
                  const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              tittle,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
