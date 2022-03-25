import 'package:flutter/material.dart';
import 'package:outline_search_bar/outline_search_bar.dart';
import 'package:shopping_app/components/category_card.dart';
import 'package:shopping_app/components/constants.dart';
import 'package:shopping_app/components/item_card.dart';
import 'package:shopping_app/screens/main_screen.dart';

import '../dto/item_dto.dart';
import '../services/item_service.dart';

class HomeScreen extends StatefulWidget {
  final void Function(ItemDTO itemDTO) callBack;
  const HomeScreen({Key? key, required this.callBack}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchFor = "All Items";
  Future<List<ItemDTO>> getItemsByCategoryOrSerachFor(String element) {
    if (element == "All Items") {
      return ItemService.getAllItems();
    } else if (categoryStringList.contains(element)) {
      return ItemService.getItemsByCategory(element);
    } else {
      return ItemService.getItemsLikeName(element);
    }
  }
  
  setCategory(String category){
    setState(() {
      _searchFor = category;
    });
  }

  addToCart(ItemDTO itemDTO){
    widget.callBack(itemDTO);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Nov, 9",
                              style: TextStyle(color: Colors.white),
                            ),
                            Row(
                              children: const [
                                Text(
                                  "Hi, ",
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white),
                                ),
                                Text("Steven!",
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.white))
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/profile.png'),
                          radius: 20,
                        ),
                      )
                    ],
                  ),
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
                            _searchFor = "All Items";
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
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0, color: kSecondaryColor),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: kSecondaryColor,
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Categories"),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "See all",
                                    style: TextStyle(color: kPrimaryColor),
                                  ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 12),
                          child: SizedBox(
                            height: 120.0,
                            child: ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: categoryList.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  CategoryCard(
                                    category: categoryList[index],
                                    callBack: setCategory,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                color: kSecondaryColor,
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
                                child: ItemCard(
                              itemDTO: snapshot.data!.elementAt(index),
                              callBack: addToCart,
                            ));
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
