import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){

        },
        child: Column(
          children: [
            Card(
              child: Image.network(
                "https://www.transparentpng.com/thumb/vegetables/all-fruits-and-vegetables-in-basket-background-transparent-veD4qx.png",
                height: 80,
                width: 80,
              ),
            ),
            const Text("Vegetables")
          ],
        ),
      ),
    );
  }
}
