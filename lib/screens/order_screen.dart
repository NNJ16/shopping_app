import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/components/constants.dart';
import 'package:shopping_app/services/order_service.dart';

import '../components/order_card.dart';
import '../dto/order_dto.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  void refresh(){
    setState(() {
      
    });
  }
  Future<List<OrderDTO>> getOrdersById() async{
      return await OrderService.getOrdersById(widget.user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
      ),
      body: FutureBuilder(
          future: getOrdersById(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              int length = snapshot.data!.length;

              if (snapshot.hasData) {
                return ListView(
                  shrinkWrap: true,
                  children: List.generate(length, (index) {
                    return Center(
                        child: OrderCard(orderDTO: snapshot.data!.elementAt(index), callBack: refresh,));
                  }),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
