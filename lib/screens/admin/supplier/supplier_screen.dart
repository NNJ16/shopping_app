import 'package:flutter/material.dart';
import 'package:outline_search_bar/outline_search_bar.dart';
import 'package:shopping_app/components/constants.dart';
import 'package:shopping_app/services/supplier_service.dart';
import '../../../components/supplier_edit_card.dart';
import '../../../dto/supplier_dto.dart';
import 'add_supplier.dart';

class SupplierScreen extends StatefulWidget {
  const SupplierScreen({Key? key}) : super(key: key);

  @override
  State<SupplierScreen> createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {
  String _searchFor = "allSuppliers";

  Future<List<SupplierDTO>> getSuppliersByCategoryOrSerachFor(String element) {
    if (element == "allSuppliers") {
      return SupplierService.getAllSuppliers();
    }else {
      return SupplierService.getSuppliersLikeName(element);
    }
  }

  void navigateToEdit(SupplierDTO supplierDTO) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddSupplierScreen(
                title: "Edit Supplier",
                supplierDTO: supplierDTO,
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
            MaterialPageRoute(builder: (context) => const AddSupplierScreen()),
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
                      _searchFor = "allSuppliers";
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
                  future: getSuppliersByCategoryOrSerachFor(_searchFor),
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
                              child: SupplierEditCard(
                                  supplierDTO: snapshot.data!.elementAt(index),
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
