import 'package:flutter/material.dart';
import 'package:shopping_app/components/constants.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Image.network(
              "https://ceylonelegance.com/wp-content/uploads/2021/07/red-apples-500g.jpg",
              height: 150,
              width: 200,
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Apple"),
                      Text("Rs.250 / 1kg"),
                    ],
                  ),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.shopping_cart,color: kPrimaryColor,))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
