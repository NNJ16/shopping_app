import 'package:flutter/material.dart';
import 'package:shopping_app/components/constants.dart';
import '../../../components/item_edit_card.dart';

class ItemScrren extends StatefulWidget {
  const ItemScrren({Key? key}) : super(key: key);

  @override
  State<ItemScrren> createState() => _ItemScrrenState();
}

class _ItemScrrenState extends State<ItemScrren> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kSecondaryColor,
      child: GridView.count(
        childAspectRatio: (1 / 1.2),
        shrinkWrap: true,
        crossAxisCount: 2,
        children: List.generate(10, (index) {
          return const Center(
            child: ItemEditCard(),
          );
        }),
      ),
    );
  }
}
