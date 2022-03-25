import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/components/constants.dart';
import 'package:shopping_app/dto/item_dto.dart';

class ItemCard extends StatefulWidget {
  final ItemDTO itemDTO;
  final void Function(ItemDTO itemDTO) callBack;
  const ItemCard({Key? key, required this.itemDTO, required this.callBack}) : super(key: key);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  String imgURL = "";

  setImage(String imgPath) async {
    final destination = 'files/' + imgPath;
    final ref = FirebaseStorage.instance.ref(destination).child('image');
    var url = await ref.getDownloadURL();
    setState(() {
      imgURL = url;
    });
  }

  @override
  void initState() {
    setImage(widget.itemDTO.imgPath);
    super.initState();
  }

  @override
  void didUpdateWidget(ItemCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    setImage(widget.itemDTO.imgPath);
  }

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
            imgURL != ""
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Image.network(
                      imgURL,
                      fit: BoxFit.fill,
                      height: 150,
                      width: 160,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      "https://media.istockphoto.com/vectors/image-preview-icon-picture-placeholder-for-website-or-uiux-design-vector-id1222357475?k=20&m=1222357475&s=170667a&w=0&h=YGycIDbBRAWkZaSvdyUFvotdGfnKhkutJhMOZtIoUKY=",
                      height: 150,
                      width: 160,
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.itemDTO.itemName),
                      Text("Rs." +
                          widget.itemDTO.itemPrice.toString() +
                          "/" +
                          widget.itemDTO.itemAmount),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      widget.callBack(widget.itemDTO);
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
