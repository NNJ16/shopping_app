import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/components/cart_empty_card.dart';
import 'package:shopping_app/components/cart_item.dart';
import 'package:shopping_app/components/constants.dart';
import 'package:shopping_app/dto/item_dto.dart';
import 'package:shopping_app/services/order_service.dart';
import '../model/order.dart';

class CartSreen extends StatefulWidget {
  final List<ItemDTO> cartItemList;
  final User user;
  final Function() callBack;
  final Function() navigateToHome;
  const CartSreen(
      {Key? key,
      required this.cartItemList,
      required this.user,
      required this.navigateToHome,
      required this.callBack})
      : super(key: key);

  @override
  State<CartSreen> createState() => _CartSreenState();
}

class _CartSreenState extends State<CartSreen> {
  double _subTotal = 0;
  double _delCharge = 0;
  double _total = 0;
  String description = "";

  void calculateSubTotal() {
    double total = 0;
    int index = 0;
    for (var item in widget.cartItemList) {
      total = total + item.itemPrice;
      if (index == 0) {
        description = item.itemName + "/" + item.itemAmount;
      } else {
        description =
            description + ", " + item.itemName + "/" + item.itemAmount;
      }
      index++;
    }
    setState(() {
      _subTotal = total;
      if (total > 0) {
        _delCharge = 250;
      } else {
        _delCharge = 0;
      }
      _total = total + _delCharge;
    });
  }

  Future<String> placeOrder() async {
    print(widget.user.uid);
    Order order = Order(
        userId: widget.user.uid,
        orderNo: "ODT"+DateTime.now().millisecondsSinceEpoch.toString(),
        dateTime: DateTime.now(),
        orderDes: description,
        status: "Pending",
        total: _total);
    return OrderService.addItem(order);
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
              widget.cartItemList.isNotEmpty
                  ? showDialog(
                      context: context,
                      builder: (BuildContext buildContext) => (AlertDialog(
                        title: const Text(
                          'Confirm Delete',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        content: Container(
                          //height: 50,
                          child: const Text(
                              'Are you sure you want to clear the cart?'),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              widget.callBack();
                              setState(() {
                                _subTotal = 0;
                                _delCharge = 0;
                                _total = 0;
                              });
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'YES',
                              style: TextStyle(color: kPrimaryColor),
                            ),
                          ),
                          TextButton(
                            onPressed: () => (Navigator.pop(context, false)),
                            child: const Text(
                              'NO',
                              style: TextStyle(color: kPrimaryColor),
                            ),
                          ),
                        ],
                      )),
                    )
                  : null;
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: widget.cartItemList.isEmpty
          ? CartEmptyCard()
          : Column(
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
                            Text((_subTotal + _delCharge).toStringAsFixed(2),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          widget.cartItemList.isNotEmpty
                              ? showDialog(
                                  context: context,
                                  builder: (BuildContext buildContext) =>
                                      (AlertDialog(
                                    title: const Text(
                                      'Order Placed',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Container(
                                      //height: 50,
                                      child: const Text(
                                          'Your order has been placed succesfully.'),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          String result = await placeOrder();
                                          if (result != "") {
                                            widget.callBack();
                                            setState(() {
                                              _subTotal = 0;
                                              _delCharge = 0;
                                              _total = 0;
                                            });
                                            Navigator.pop(context);
                                            widget.navigateToHome();
                                          }
                                        },
                                        child: const Text(
                                          'Ok',
                                          style:
                                              TextStyle(color: kPrimaryColor),
                                        ),
                                      ),
                                    ],
                                  )),
                                )
                              : null;
                        },
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
