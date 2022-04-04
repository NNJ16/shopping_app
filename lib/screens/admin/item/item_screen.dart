import 'package:flutter/material.dart';
import 'package:outline_search_bar/outline_search_bar.dart';
import 'package:shopping_app/components/constants.dart';
import 'package:shopping_app/services/item_service.dart';
import '../../../components/item_edit_card.dart';
import '../../../dto/item_dto.dart';
import 'add_item.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({Key? key}) : super(key: key);

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  String _searchFor = "allItems";

  Future<List<ItemDTO>> getItemsByCategoryOrSerachFor(String element) {
    if (element == "allItems") {
      return ItemService.getAllItems();
    } else if (categoryStringList.contains(element)) {
      return ItemService.getItemsByCategory(element);
    } else {
      return ItemService.getItemsLikeName(element);
    }
  }

  void navigateToEdit(ItemDTO itemDTO) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddItemScreen(
                title: "Edit Item",
                itemDTO: itemDTO,
              )),
    ).then((_) => setState(() {}));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddItemScreen()),
          ).then((_) => setState(() {}));
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(
          Icons.add,
          size: 35,
        ),
      ),
      body: Container(
        height: double.infinity,
        color: kSecondaryColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 35,
                child: OutlineSearchBar(
                  borderColor: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                  cursorColor: kPrimaryColor,
                  searchButtonIconColor: kPrimaryColor,
                  onClearButtonPressed: (String e) {
                    setState(() {
                      _searchFor = "allItems";
                    });
                  },
                  onSearchButtonPressed: (String searchFor) {
                    setState(() {
                      _searchFor = searchFor;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: FutureBuilder(
                  future: getItemsByCategoryOrSerachFor(_searchFor),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data != null) {
                      int length = snapshot.data!.length;

                      if (snapshot.hasData) {
                        return GridView.count(
                          childAspectRatio: (1 / 1.2),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          children: List.generate(length, (index) {
                            return Center(
                              child: ItemEditCard(
                                  itemDTO: snapshot.data!.elementAt(index),
                                  callBack: navigateToEdit,
                                  ),
                            );
                          }),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
