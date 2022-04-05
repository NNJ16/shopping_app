import 'package:flutter/material.dart';

class CartEmptyCard extends StatefulWidget {
  const CartEmptyCard({Key? key}) : super(key: key);

  @override
  State<CartEmptyCard> createState() => _CartEmptyCardState();
}

class _CartEmptyCardState extends State<CartEmptyCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Image.asset("assets/images/emptycart.png"),
          const Text("Looks like you haven't added", style: TextStyle(fontSize: 16, color: Colors.black38),),
          const SizedBox(
            height: 8,
          ),
          const Text("Anything to your cart yet.", style: TextStyle(fontSize: 16, color: Colors.black38),)
        ],
      ),
    );
  }
}
