import 'package:flutter/material.dart';
import 'package:shopping_app/model/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({Key? key, required this.category}) : super(key: key);

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
                category.url,
                height: 80,
                width: 80,
                fit: BoxFit.fill,
              ),
            ),
            Text(category.category)
          ],
        ),
      ),
    );
  }
}
