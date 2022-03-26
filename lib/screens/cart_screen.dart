import 'package:flutter/material.dart';
import 'package:shopping_app/components/cart_item.dart';
import 'package:shopping_app/components/constants.dart';
import 'package:shopping_app/dto/item_dto.dart';

class CartSreen extends StatefulWidget {
  final List<ItemDTO> cartItemList;
  final void Function() callBack;
  const CartSreen(
      {Key? key, required this.cartItemList, required this.callBack})
      : super(key: key);

  @override
  State<CartSreen> createState() => _CartSreenState();
}

class _CartSreenState extends State<CartSreen> {
  double _subTotal = 0;
  double _delCharge = 0;
  double _total = 0;

  void calculateSubTotal() {
    double total = 0;
    for (var items in widget.cartItemList) {
      total = total + items.itemPrice;
    }
    setState(() {
      _subTotal = total;
      if(total > 0){
        _delCharge = 250;
      }else{
        _delCharge = 0;
      }
      _total = total + _delCharge;
    });
  }

  @override
  void initState() {
    calculateSubTotal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: const Text("My Cart"),
        actions: [
          IconButton(
            onPressed: () {
              widget.callBack();
              setState(() {
                _subTotal = 0;
                _delCharge = 0;
                _total = 0;
              });
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: widget.cartItemList.length,
                itemBuilder: (context, index) {
                  return (CartItem(
                    itemDTO: widget.cartItemList.elementAt(index),
                  ));
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Sub Total (Rs.)"),
                      Text(_subTotal.toStringAsFixed(2)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Delivery Charges (Rs.)"),
                      Text(_delCharge.toString()),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total (Rs.)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text((_subTotal +_delCharge).toStringAsFixed(2),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Container(
                    width: double.infinity,
                    child: const Center(child: Text('Checkout')),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(),
                      elevation: 0,
                      primary: Colors.amber[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
