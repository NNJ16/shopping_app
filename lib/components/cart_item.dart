import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/dto/item_dto.dart';

class CartItem extends StatefulWidget {
  final ItemDTO itemDTO;
  const CartItem({Key? key, required this.itemDTO}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
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
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                imgURL != ""
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: Image.network(
                          imgURL,
                          fit: BoxFit.fill,
                          height: 55,
                          width: 65,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          "https://media.istockphoto.com/vectors/image-preview-icon-picture-placeholder-for-website-or-uiux-design-vector-id1222357475?k=20&m=1222357475&s=170667a&w=0&h=YGycIDbBRAWkZaSvdyUFvotdGfnKhkutJhMOZtIoUKY=",
                          height: 55,
                          width: 65,
                        ),
                      ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.itemDTO.itemName),
                    Text("Rs." +
                        widget.itemDTO.itemPrice.toString() +
                        "/" +
                        widget.itemDTO.itemAmount),
                  ],
                )
              ],
            ),
            Text("Rs." + widget.itemDTO.itemPrice.toString())
          ],
        ),
      ),
    );
  }
}
