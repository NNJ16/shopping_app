import 'package:flutter/material.dart';
import 'package:shopping_app/components/constants.dart';

class AccountButton extends StatelessWidget {
  const AccountButton(
      {required this.title,
      required this.subTitle,
      required this.icon,
      required this.onPressed});
  final String title;
  final String subTitle;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          alignment: Alignment.centerLeft, primary: Colors.black54),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: kPrimaryColor,
                  size: 30,
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subTitle,
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Icon(
              Icons.chevron_right,
              color: kPrimaryColor,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
