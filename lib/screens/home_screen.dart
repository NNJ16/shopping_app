import 'package:flutter/material.dart';
import 'package:outline_search_bar/outline_search_bar.dart';
import 'package:shopping_app/components/category_card.dart';
import 'package:shopping_app/components/constants.dart';
import 'package:shopping_app/components/item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                            const Text("Nov, 9", style: TextStyle(color: Colors.white),),
                            Row(
                              children: const [
                                Text(
                                  "Hi, ",
                                  style: TextStyle(fontSize: 24, color: Colors.white),
                                ),
                                Text("Steven!", style: TextStyle(fontSize: 24, color: Colors.white))
                              ],
                            ),
                          ],
                        ),
                      ),
                      Image.network(
                        "https://www.pngitem.com/pimgs/m/78-786293_1240-x-1240-0-avatar-profile-icon-png.png",
                        width: 60,
                        height: 60,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 35,
                      child: OutlineSearchBar(
                        borderColor: kPrimaryColor,
                        borderRadius: BorderRadius.circular(20),
                        cursorColor: kPrimaryColor,
                        searchButtonIconColor: kPrimaryColor,
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
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Categories"),
                              TextButton(onPressed:(){}, child: const Text("See all", style: TextStyle(color: kPrimaryColor),))
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
                              itemCount: 15,
                              itemBuilder: (BuildContext context, int index) =>
                                  const CategoryCard(),
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
                child: GridView.count(
                   childAspectRatio: (1 / 1.2),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: List.generate(10, (index) {
                    return const Center(
                      child:ItemCard(),
                    );
                  }),
                ),
              ),
            ),
          ],
        ));
  }
}
